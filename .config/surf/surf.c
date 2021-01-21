/* See LICENSE file for copyright and license details.
 *
 * To understand surf, start reading main().
 */
#include <sys/file.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <libgen.h>
#include <limits.h>
#include <pwd.h>
#include <regex.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <gdk/gdk.h>
#include <gdk/gdkkeysyms.h>
#include <gdk/gdkx.h>
#include <glib/gstdio.h>
#include <gtk/gtk.h>
#include <gtk/gtkx.h>
#include <JavaScriptCore/JavaScript.h>
#include <webkit2/webkit2.h>
#include <X11/X.h>
#include <X11/Xatom.h>

#include "arg.h"

#define LENGTH(x)               (sizeof(x) / sizeof(x[0]))
#define CLEANMASK(mask)         (mask & (MODKEY|GDK_SHIFT_MASK))
#define SETB(p, s)              [p] = { { .b = s }, }
#define SETI(p, s)              [p] = { { .i = s }, }
#define SETV(p, s)              [p] = { { .v = s }, }
#define SETF(p, s)              [p] = { { .f = s }, }
#define FSETB(p, s)             [p] = { { .b = s }, 1 }
#define FSETI(p, s)             [p] = { { .i = s }, 1 }
#define FSETV(p, s)             [p] = { { .v = s }, 1 }
#define FSETF(p, s)             [p] = { { .f = s }, 1 }
#define CSETB(p, s)             [p] = (Parameter){ { .b = s }, 1 }
#define CSETI(p, s)             [p] = (Parameter){ { .i = s }, 1 }
#define CSETV(p, s)             [p] = (Parameter){ { .v = s }, 1 }
#define CSETF(p, s)             [p] = (Parameter){ { .f = s }, 1 }

enum { AtomFind, AtomGo, AtomUri, AtomLast };

enum {
	OnDoc   = WEBKIT_HIT_TEST_RESULT_CONTEXT_DOCUMENT,
	OnLink  = WEBKIT_HIT_TEST_RESULT_CONTEXT_LINK,
	OnImg   = WEBKIT_HIT_TEST_RESULT_CONTEXT_IMAGE,
	OnMedia = WEBKIT_HIT_TEST_RESULT_CONTEXT_MEDIA,
	OnEdit  = WEBKIT_HIT_TEST_RESULT_CONTEXT_EDITABLE,
	OnBar   = WEBKIT_HIT_TEST_RESULT_CONTEXT_SCROLLBAR,
	OnSel   = WEBKIT_HIT_TEST_RESULT_CONTEXT_SELECTION,
	OnAny   = OnDoc | OnLink | OnImg | OnMedia | OnEdit | OnBar | OnSel,
};

typedef enum {
	AcceleratedCanvas,
	CaretBrowsing,
	CookiePolicies,
	DiskCache,
	DNSPrefetch,
	FontSize,
	FrameFlattening,
	Geolocation,
	HideBackground,
	Inspector,
	JavaScript,
	KioskMode,
	LoadImages,
	MediaManualPlay,
	Plugins,
	PreferredLanguages,
	RunInFullscreen,
	ScrollBars,
	ShowIndicators,
	SiteQuirks,
	SpellChecking,
	SpellLanguages,
	StrictSSL,
	Style,
	ZoomLevel,
	ParameterLast,
} ParamName;

typedef union {
	int b;
	int i;
	float f;
	const void *v;
} Arg;

typedef struct {
	Arg val;
	int force;
} Parameter;

typedef struct Client {
	GtkWidget *win;
	WebKitWebView *view;
	WebKitWebInspector *inspector;
	WebKitFindController *finder;
	WebKitHitTestResult *mousepos;
	GTlsCertificateFlags tlsflags;
	Window xid;
	int progress, fullscreen;
	const char *title, *overtitle, *targeturi;
	const char *needle;
	struct Client *next;
} Client;

typedef struct {
	guint mod;
	guint keyval;
	void (*func)(Client *c, const Arg *a);
	const Arg arg;
} Key;

typedef struct {
	unsigned int target;
	unsigned int mask;
	guint button;
	void (*func)(Client *c, const Arg *a, WebKitHitTestResult *h);
	const Arg arg;
	unsigned int stopevent;
} Button;

typedef struct {
	const char *uri;
	Parameter config[ParameterLast];
	regex_t re;
} UriParameters;

typedef struct {
	char *regex;
	char *style;
	regex_t re;
} SiteStyle;

/* Surf */
static void usage(void);
static void die(const char *errstr, ...);
static void setup(void);
static void sigchld(int unused);
static void sighup(int unused);
static char *buildfile(const char *path);
static char *buildpath(const char *path);
static const char *getuserhomedir(const char *user);
static const char *getcurrentuserhomedir(void);
static Client *newclient(Client *c);
static void loaduri(Client *c, const Arg *a);
static const char *geturi(Client *c);
static void setatom(Client *c, int a, const char *v);
static const char *getatom(Client *c, int a);
static void updatetitle(Client *c);
static void gettogglestats(Client *c);
static void getpagestats(Client *c);
static WebKitCookieAcceptPolicy cookiepolicy_get(void);
static char cookiepolicy_set(const WebKitCookieAcceptPolicy p);
static void seturiparameters(Client *c, const char *uri);
static void setparameter(Client *c, int refresh, ParamName p, const Arg *a);
static const char *getstyle(const char *uri);
static void setstyle(Client *c, const char *stylefile);
static void runscript(Client *c);
static void evalscript(Client *c, const char *jsstr, ...);
static void updatewinid(Client *c);
static void handleplumb(Client *c, const char *uri);
static void newwindow(Client *c, const Arg *a, int noembed);
static void spawn(Client *c, const Arg *a);
static void destroyclient(Client *c);
static void cleanup(void);

/* GTK/WebKit */
static WebKitWebView *newview(Client *c, WebKitWebView *rv);
static void initwebextensions(WebKitWebContext *wc, Client *c);
static GtkWidget *createview(WebKitWebView *v, WebKitNavigationAction *a,
                             Client *c);
static gboolean buttonreleased(GtkWidget *w, GdkEvent *e, Client *c);
static GdkFilterReturn processx(GdkXEvent *xevent, GdkEvent *event,
                                gpointer d);
static gboolean winevent(GtkWidget *w, GdkEvent *e, Client *c);
static void showview(WebKitWebView *v, Client *c);
static GtkWidget *createwindow(Client *c);
static void loadchanged(WebKitWebView *v, WebKitLoadEvent e, Client *c);
static void progresschanged(WebKitWebView *v, GParamSpec *ps, Client *c);
static void titlechanged(WebKitWebView *view, GParamSpec *ps, Client *c);
static void mousetargetchanged(WebKitWebView *v, WebKitHitTestResult *h,
                               guint modifiers, Client *c);
static gboolean permissionrequested(WebKitWebView *v,
                                    WebKitPermissionRequest *r, Client *c);
static gboolean decidepolicy(WebKitWebView *v, WebKitPolicyDecision *d,
                             WebKitPolicyDecisionType dt, Client *c);
static void decidenavigation(WebKitPolicyDecision *d, Client *c);
static void decidenewwindow(WebKitPolicyDecision *d, Client *c);
static void decideresource(WebKitPolicyDecision *d, Client *c);
static void downloadstarted(WebKitWebContext *wc, WebKitDownload *d,
                            Client *c);
static void responsereceived(WebKitDownload *d, GParamSpec *ps, Client *c);
static void download(Client *c, WebKitURIResponse *r);
static void closeview(WebKitWebView *v, Client *c);
static void destroywin(GtkWidget* w, Client *c);

/* Hotkeys */
static void pasteuri(GtkClipboard *clipboard, const char *text, gpointer d);
static void reload(Client *c, const Arg *a);
static void print(Client *c, const Arg *a);
static void clipboard(Client *c, const Arg *a);
static void zoom(Client *c, const Arg *a);
static void scroll(Client *c, const Arg *a);
static void navigate(Client *c, const Arg *a);
static void stop(Client *c, const Arg *a);
static void toggle(Client *c, const Arg *a);
static void togglefullscreen(Client *c, const Arg *a);
static void togglecookiepolicy(Client *c, const Arg *a);
static void toggleinspector(Client *c, const Arg *a);
static void find(Client *c, const Arg *a);

/* Buttons */
static void clicknavigate(Client *c, const Arg *a, WebKitHitTestResult *h);
static void clicknewwindow(Client *c, const Arg *a, WebKitHitTestResult *h);
static void clickexternplayer(Client *c, const Arg *a, WebKitHitTestResult *h);

static char winid[64];
static char togglestats[10];
static char pagestats[2];
static Atom atoms[AtomLast];
static Window embed;
static int showxid;
static int cookiepolicy;
static Display *dpy;
static Client *clients;
static GdkDevice *gdkkb;
static char *stylefile;
static const char *useragent;
static Parameter *curconfig;
char *argv0;

/* configuration, allows nested code to access above variables */
#include "config.h"

void
usage(void)
{
	die("usage: %s [-bBdDfFgGiIkKmMnNpPsSvx] [-a cookiepolicies ] "
	    "[-c cookiefile] [-e xid] [-r scriptfile] [-t stylefile] "
	    "[-u useragent] [-z zoomlevel] [uri]\n", basename(argv0));
}

void
die(const char *errstr, ...)
{
	va_list ap;

	va_start(ap, errstr);
	vfprintf(stderr, errstr, ap);
	va_end(ap);
	exit(1);
}

void
setup(void)
{
	GdkDisplay *gdpy;
	int i, j;

	/* clean up any zombies immediately */
	sigchld(0);
	if (signal(SIGHUP, sighup) == SIG_ERR)
		die("Can't install SIGHUP handler");

	if (!(dpy = XOpenDisplay(NULL)))
		die("Can't open default display");

	/* atoms */
	atoms[AtomFind] = XInternAtom(dpy, "_SURF_FIND", False);
	atoms[AtomGo] = XInternAtom(dpy, "_SURF_GO", False);
	atoms[AtomUri] = XInternAtom(dpy, "_SURF_URI", False);

	gtk_init(NULL, NULL);

	gdpy = gdk_display_get_default();

	curconfig = defconfig;

	/* dirs and files */
	cookiefile = buildfile(cookiefile);
	scriptfile = buildfile(scriptfile);
	cachedir   = buildpath(cachedir);

	gdkkb = gdk_seat_get_keyboard(gdk_display_get_default_seat(gdpy));

	if (!stylefile) {
		styledir = buildpath(styledir);
		for (i = 0; i < LENGTH(styles); ++i) {
			if (regcomp(&(styles[i].re), styles[i].regex,
			    REG_EXTENDED)) {
				fprintf(stderr,
				        "Could not compile regex: %s\n",
				        styles[i].regex);
				styles[i].regex = NULL;
			}
			styles[i].style = g_strconcat(styledir, "/",
			                              styles[i].style, NULL);
		}
		g_free(styledir);
	} else {
		stylefile = buildfile(stylefile);
	}

	for (i = 0; i < LENGTH(uriparams); ++i) {
		if (!regcomp(&(uriparams[i].re), uriparams[i].uri,
		    REG_EXTENDED)) {
			/* copy default parameters if they are not already set
			 * or if they are forced */
			for (j = 0; j < ParameterLast; ++j) {
				if (!uriparams[i].config[j].force ||
				    defconfig[j].force)
					uriparams[i].config[j] = defconfig[j];
			}
		} else {
			fprintf(stderr,
			        "Could not compile regex: %s\n",
			        uriparams[i].uri);
			uriparams[i].uri = NULL;
		}
	}
}

void
sigchld(int unused)
{
	if (signal(SIGCHLD, sigchld) == SIG_ERR)
		die("Can't install SIGCHLD handler");
	while (waitpid(-1, NULL, WNOHANG) > 0)
		;
}

void
sighup(int unused)
{
	Arg a = { .b = 0 };
	Client *c;

	for (c = clients; c; c = c->next)
		reload(c, &a);
}

char *
buildfile(const char *path)
{
	char *dname, *bname, *bpath, *fpath;
	FILE *f;

	dname = g_path_get_dirname(path);
	bname = g_path_get_basename(path);

	bpath = buildpath(dname);
	g_free(dname);

	fpath = g_build_filename(bpath, bname, NULL);
	g_free(bpath);
	g_free(bname);

	if (!(f = fopen(fpath, "a")))
		die("Could not open file: %s\n", fpath);

	g_chmod(fpath, 0600); /* always */
	fclose(f);

	return fpath;
}

static const char*
getuserhomedir(const char *user)
{
	struct passwd *pw = getpwnam(user);

	if (!pw)
		die("Can't get user %s login information.\n", user);

	return pw->pw_dir;
}

static const char*
getcurrentuserhomedir(void)
{
	const char *homedir;
	const char *user;
	struct passwd *pw;

	homedir = getenv("HOME");
	if (homedir)
		return homedir;

	user = getenv("USER");
	if (user)
		return getuserhomedir(user);

	pw = getpwuid(getuid());
	if (!pw)
		die("Can't get current user home directory\n");

	return pw->pw_dir;
}

char *
buildpath(const char *path)
{
	char *apath, *name, *p, *fpath;
	const char *homedir;

	if (path[0] == '~') {
		if (path[1] == '/' || path[1] == '\0') {
			p = (char *)&path[1];
			homedir = getcurrentuserhomedir();
		} else {
			if ((p = strchr(path, '/')))
				name = g_strndup(&path[1], --p - path);
			else
				name = g_strdup(&path[1]);

			homedir = getuserhomedir(name);
			g_free(name);
		}
		apath = g_build_filename(homedir, p, NULL);
	} else {
		apath = g_strdup(path);
	}

	/* creating directory */
	if (g_mkdir_with_parents(apath, 0700) < 0)
		die("Could not access directory: %s\n", apath);

	fpath = realpath(apath, NULL);
	g_free(apath);

	return fpath;
}

Client *
newclient(Client *rc)
{
	Client *c;

	if (!(c = calloc(1, sizeof(Client))))
		die("Cannot malloc!\n");

	c->next = clients;
	clients = c;

	c->progress = 100;
	c->tlsflags = G_TLS_CERTIFICATE_VALIDATE_ALL + 1;
	c->view = newview(c, rc ? rc->view : NULL);

	return c;
}

void
loaduri(Client *c, const Arg *a)
{
	struct stat st;
	char *url, *path;
	const char *uri = a->v;

	if (g_strcmp0(uri, "") == 0)
		return;

	if (g_str_has_prefix(uri, "http://")  ||
	    g_str_has_prefix(uri, "https://") ||
	    g_str_has_prefix(uri, "file://")  ||
	    g_str_has_prefix(uri, "about:")) {
		url = g_strdup(uri);
	} else if (!stat(uri, &st) && (path = realpath(uri, NULL))) {
		url = g_strdup_printf("file://%s", path);
		free(path);
	} else {
		url = g_strdup_printf("http://%s", uri);
	}

	setatom(c, AtomUri, url);

	if (strcmp(url, geturi(c)) == 0) {
		reload(c, a);
	} else {
		webkit_web_view_load_uri(c->view, url);
		updatetitle(c);
	}

	g_free(url);
}

const char *
geturi(Client *c)
{
	const char *uri;

	if (!(uri = webkit_web_view_get_uri(c->view)))
		uri = "about:blank";
	return uri;
}

void
setatom(Client *c, int a, const char *v)
{
	XSync(dpy, False);
	XChangeProperty(dpy, c->xid,
	                atoms[a], XA_STRING, 8, PropModeReplace,
	                (unsigned char *)v, strlen(v) + 1);
}

const char *
getatom(Client *c, int a)
{
	static char buf[BUFSIZ];
	Atom adummy;
	int idummy;
	unsigned long ldummy;
	unsigned char *p = NULL;

	XGetWindowProperty(dpy, c->xid, atoms[a], 0L, BUFSIZ, False, XA_STRING,
	                   &adummy, &idummy, &ldummy, &ldummy, &p);
	if (p)
		strncpy(buf, (char *)p, LENGTH(buf) - 1);
	else
		buf[0] = '\0';
	XFree(p);

	return buf;
}

void
updatetitle(Client *c)
{
	char *title;
	const char *name = c->overtitle ? c->overtitle :
	                   c->title ? c->title : "";

	if (curconfig[ShowIndicators].val.b) {
		gettogglestats(c);
		getpagestats(c);

		if (c->progress != 100)
			title = g_strdup_printf("[%i%%] %s:%s | %s",
			        c->progress, togglestats, pagestats, name);
		else
			title = g_strdup_printf("%s:%s | %s",
			        togglestats, pagestats, name);

		gtk_window_set_title(GTK_WINDOW(c->win), title);
		g_free(title);
	} else {
		gtk_window_set_title(GTK_WINDOW(c->win), name);
	}
}

void
gettogglestats(Client *c)
{
	togglestats[0] = cookiepolicy_set(cookiepolicy_get());
	togglestats[1] = curconfig[CaretBrowsing].val.b ?   'C' : 'c';
	togglestats[2] = curconfig[Geolocation].val.b ?     'G' : 'g';
	togglestats[3] = curconfig[DiskCache].val.b ?       'D' : 'd';
	togglestats[4] = curconfig[LoadImages].val.b ?      'I' : 'i';
	togglestats[5] = curconfig[JavaScript].val.b ?      'S' : 's';
	togglestats[6] = curconfig[Plugins].val.b ?         'V' : 'v';
	togglestats[7] = curconfig[Style].val.b ?           'M' : 'm';
	togglestats[8] = curconfig[FrameFlattening].val.b ? 'F' : 'f';
	togglestats[9] = '\0';
}

void
getpagestats(Client *c)
{
	pagestats[0] = c->tlsflags > G_TLS_CERTIFICATE_VALIDATE_ALL ? '-' :
	               c->tlsflags > 0 ? 'U' : 'T';
	pagestats[1] = '\0';
}

WebKitCookieAcceptPolicy
cookiepolicy_get(void)
{
	switch (((char *)curconfig[CookiePolicies].val.v)[cookiepolicy]) {
	case 'a':
		return WEBKIT_COOKIE_POLICY_ACCEPT_NEVER;
	case '@':
		return WEBKIT_COOKIE_POLICY_ACCEPT_NO_THIRD_PARTY;
	default: /* fallthrough */
	case 'A':
		return WEBKIT_COOKIE_POLICY_ACCEPT_ALWAYS;
	}
}

char
cookiepolicy_set(const WebKitCookieAcceptPolicy p)
{
	switch (p) {
	case WEBKIT_COOKIE_POLICY_ACCEPT_NEVER:
		return 'a';
	case WEBKIT_COOKIE_POLICY_ACCEPT_NO_THIRD_PARTY:
		return '@';
	default: /* fallthrough */
	case WEBKIT_COOKIE_POLICY_ACCEPT_ALWAYS:
		return 'A';
	}
}

void
seturiparameters(Client *c, const char *uri)
{
	int i;

	for (i = 0; i < LENGTH(uriparams); ++i) {
		if (uriparams[i].uri &&
		    !regexec(&(uriparams[i].re), uri, 0, NULL, 0)) {
			curconfig = uriparams[i].config;
			break;
		}
	}

	for (i = 0; i < ParameterLast; ++i)
		setparameter(c, 0, i, &curconfig[i].val);
}

void
setparameter(Client *c, int refresh, ParamName p, const Arg *a)
{
	GdkRGBA bgcolor = { 0 };
	WebKitSettings *s = webkit_web_view_get_settings(c->view);

	switch (p) {
	case AcceleratedCanvas:
		webkit_settings_set_enable_accelerated_2d_canvas(s, a->b);
		break;
	case CaretBrowsing:
		webkit_settings_set_enable_caret_browsing(s, a->b);
		refresh = 0;
		break;
	case CookiePolicies:
		webkit_cookie_manager_set_accept_policy(
		    webkit_web_context_get_cookie_manager(
		    webkit_web_view_get_context(c->view)),
		    cookiepolicy_get());
		refresh = 0;
		break;
	case DiskCache:
		webkit_web_context_set_cache_model(
		    webkit_web_view_get_context(c->view), a->b ?
		    WEBKIT_CACHE_MODEL_WEB_BROWSER :
		    WEBKIT_CACHE_MODEL_DOCUMENT_VIEWER);
		return; /* do not update */
	case DNSPrefetch:
		webkit_settings_set_enable_dns_prefetching(s, a->b);
		return; /* do not update */
	case FontSize:
		webkit_settings_set_default_font_size(s, a->i);
		return; /* do not update */
	case FrameFlattening:
		webkit_settings_set_enable_frame_flattening(s, a->b);
		break;
	case Geolocation:
		refresh = 0;
		break;
	case HideBackground:
		if (a->b)
			webkit_web_view_set_background_color(c->view, &bgcolor);
		return; /* do not update */
	case Inspector:
		webkit_settings_set_enable_developer_extras(s, a->b);
		return; /* do not update */
	case JavaScript:
		webkit_settings_set_enable_javascript(s, a->b);
		break;
	case KioskMode:
		return; /* do nothing */
	case LoadImages:
		webkit_settings_set_auto_load_images(s, a->b);
		break;
	case MediaManualPlay:
		webkit_settings_set_media_playback_requires_user_gesture(s, a->b);
		break;
	case Plugins:
		webkit_settings_set_enable_plugins(s, a->b);
		break;
	case PreferredLanguages:
		return; /* do nothing */
	case RunInFullscreen:
		return; /* do nothing */
	case ScrollBars:
		/* Disabled until we write some WebKitWebExtension for
		 * manipulating the DOM directly.
		enablescrollbars = !enablescrollbars;
		evalscript(c, "document.documentElement.style.overflow = '%s'",
		    enablescrollbars ? "auto" : "hidden");
		*/
		return; /* do not update */
	case ShowIndicators:
		break;
	case SiteQuirks:
		webkit_settings_set_enable_site_specific_quirks(s, a->b);
		break;
	case SpellChecking:
		webkit_web_context_set_spell_checking_enabled(
		    webkit_web_view_get_context(c->view), a->b);
		return; /* do not update */
	case SpellLanguages:
		return; /* do nothing */
	case StrictSSL:
		webkit_web_context_set_tls_errors_policy(
		    webkit_web_view_get_context(c->view), a->b ?
		    WEBKIT_TLS_ERRORS_POLICY_FAIL :
		    WEBKIT_TLS_ERRORS_POLICY_IGNORE);
		return; /* do not update */
	case Style:
		if (a->b)
			setstyle(c, getstyle(geturi(c)));
		else
			webkit_user_content_manager_remove_all_style_sheets(
			    webkit_web_view_get_user_content_manager(c->view));
		refresh = 0;
		break;
	case ZoomLevel:
		webkit_web_view_set_zoom_level(c->view, a->f);
		return; /* do not update */
	default:
		return; /* do nothing */
	}

	updatetitle(c);
	if (refresh)
		reload(c, a);
}

const char *
getstyle(const char *uri)
{
	int i;

	if (stylefile)
		return stylefile;

	for (i = 0; i < LENGTH(styles); ++i) {
		if (styles[i].regex &&
		    !regexec(&(styles[i].re), uri, 0, NULL, 0))
			return styles[i].style;
	}

	return "";
}

void
setstyle(Client *c, const char *stylefile)
{
	gchar *style;

	if (!g_file_get_contents(stylefile, &style, NULL, NULL)) {
		fprintf(stderr, "Could not read style file: %s\n", stylefile);
		return;
	}

	webkit_user_content_manager_add_style_sheet(
	    webkit_web_view_get_user_content_manager(c->view),
	    webkit_user_style_sheet_new(style,
	    WEBKIT_USER_CONTENT_INJECT_ALL_FRAMES,
	    WEBKIT_USER_STYLE_LEVEL_USER,
	    NULL, NULL));

	g_free(style);
}

void
runscript(Client *c)
{
	gchar *script;
	gsize l;

	if (g_file_get_contents(scriptfile, &script, &l, NULL) && l)
		evalscript(c, script);
	g_free(script);
}

void
evalscript(Client *c, const char *jsstr, ...)
{
	va_list ap;
	gchar *script;

	va_start(ap, jsstr);
	script = g_strdup_vprintf(jsstr, ap);
	va_end(ap);

	webkit_web_view_run_javascript(c->view, script, NULL, NULL, NULL);
	g_free(script);
}

void
updatewinid(Client *c)
{
	snprintf(winid, LENGTH(winid), "%lu", c->xid);
}

void
handleplumb(Client *c, const char *uri)
{
	Arg a = (Arg)PLUMB(uri);
	spawn(c, &a);
}

void
newwindow(Client *c, const Arg *a, int noembed)
{
	int i = 0;
	char tmp[64];
	const char *cmd[26], *uri;
	const Arg arg = { .v = cmd };

	cmd[i++] = argv0;
	cmd[i++] = "-a";
	cmd[i++] = curconfig[CookiePolicies].val.v;
	cmd[i++] = curconfig[ScrollBars].val.b ? "-B" : "-b";
	if (cookiefile && g_strcmp0(cookiefile, "")) {
		cmd[i++] = "-c";
		cmd[i++] = cookiefile;
	}
	cmd[i++] = curconfig[DiskCache].val.b ? "-D" : "-d";
	if (embed && !noembed) {
		cmd[i++] = "-e";
		snprintf(tmp, LENGTH(tmp), "%lu", embed);
		cmd[i++] = tmp;
	}
	cmd[i++] = curconfig[RunInFullscreen].val.b ? "-F" : "-f" ;
	cmd[i++] = curconfig[Geolocation].val.b ?     "-G" : "-g" ;
	cmd[i++] = curconfig[LoadImages].val.b ?      "-I" : "-i" ;
	cmd[i++] = curconfig[KioskMode].val.b ?       "-K" : "-k" ;
	cmd[i++] = curconfig[Style].val.b ?           "-M" : "-m" ;
	cmd[i++] = curconfig[Inspector].val.b ?       "-N" : "-n" ;
	cmd[i++] = curconfig[Plugins].val.b ?         "-P" : "-p" ;
	if (scriptfile && g_strcmp0(scriptfile, "")) {
		cmd[i++] = "-r";
		cmd[i++] = scriptfile;
	}
	cmd[i++] = curconfig[JavaScript].val.b ? "-S" : "-s";
	if (stylefile && g_strcmp0(stylefile, "")) {
		cmd[i++] = "-t";
		cmd[i++] = stylefile;
	}
	if (fulluseragent && g_strcmp0(fulluseragent, "")) {
		cmd[i++] = "-u";
		cmd[i++] = fulluseragent;
	}
	if (showxid)
		cmd[i++] = "-x";
	/* do not keep zoom level */
	cmd[i++] = "--";
	if ((uri = a->v))
		cmd[i++] = uri;
	cmd[i] = NULL;

	spawn(c, &arg);
}

void
spawn(Client *c, const Arg *a)
{
	if (fork() == 0) {
		if (dpy)
			close(ConnectionNumber(dpy));
		setsid();
		execvp(((char **)a->v)[0], (char **)a->v);
		fprintf(stderr, "%s: execvp %s", argv0, ((char **)a->v)[0]);
		perror(" failed");
		exit(1);
	}
}

void
destroyclient(Client *c)
{
	Client *p;

	webkit_web_view_stop_loading(c->view);
	/* Not needed, has already been called
	gtk_widget_destroy(c->win);
	 */

	for (p = clients; p && p->next != c; p = p->next)
		;
	if (p)
		p->next = c->next;
	else
		clients = c->next;
	free(c);
}

void
cleanup(void)
{
	while (clients)
		destroyclient(clients);
	g_free(cookiefile);
	g_free(scriptfile);
	g_free(stylefile);
	g_free(cachedir);
	XCloseDisplay(dpy);
}

WebKitWebView *
newview(Client *c, WebKitWebView *rv)
{
	WebKitWebView *v;
	WebKitSettings *settings;
	WebKitUserContentManager *contentmanager;
	WebKitWebContext *context;

	/* Webview */
	if (rv) {
		v = WEBKIT_WEB_VIEW(
		    webkit_web_view_new_with_related_view(rv));
	} else {
		settings = webkit_settings_new_with_settings(
		   "auto-load-images", curconfig[LoadImages].val.b,
		   "default-font-size", curconfig[FontSize].val.i,
		   "enable-caret-browsing", curconfig[CaretBrowsing].val.b,
		   "enable-developer-extras", curconfig[Inspector].val.b,
		   "enable-dns-prefetching", curconfig[DNSPrefetch].val.b,
		   "enable-frame-flattening", curconfig[FrameFlattening].val.b,
		   "enable-html5-database", curconfig[DiskCache].val.b,
		   "enable-html5-local-storage", curconfig[DiskCache].val.b,
		   "enable-javascript", curconfig[JavaScript].val.b,
		   "enable-plugins", curconfig[Plugins].val.b,
		   "enable-accelerated-2d-canvas", curconfig[AcceleratedCanvas].val.b,
		   "enable-site-specific-quirks", curconfig[SiteQuirks].val.b,
		   "media-playback-requires-user-gesture", curconfig[MediaManualPlay].val.b,
		   NULL);
/* For mor interesting settings, have a look at
 * http://webkitgtk.org/reference/webkit2gtk/stable/WebKitSettings.html */

		if (strcmp(fulluseragent, "")) {
			webkit_settings_set_user_agent(settings, fulluseragent);
		} else if (surfuseragent) {
			webkit_settings_set_user_agent_with_application_details(
			    settings, "Surf", VERSION);
		}
		useragent = webkit_settings_get_user_agent(settings);

		contentmanager = webkit_user_content_manager_new();

		context = webkit_web_context_new_with_website_data_manager(
		          webkit_website_data_manager_new(
		          "base-cache-directory", cachedir,
		          "base-data-directory", cachedir,
		          NULL));

		/* rendering process model, can be a shared unique one
		 * or one for each view */
		webkit_web_context_set_process_model(context,
		    WEBKIT_PROCESS_MODEL_MULTIPLE_SECONDARY_PROCESSES);
		/* ssl */
		webkit_web_context_set_tls_errors_policy(context,
		    curconfig[StrictSSL].val.b ? WEBKIT_TLS_ERRORS_POLICY_FAIL :
		    WEBKIT_TLS_ERRORS_POLICY_IGNORE);
		/* disk cache */
		webkit_web_context_set_cache_model(context,
		    curconfig[DiskCache].val.b ? WEBKIT_CACHE_MODEL_WEB_BROWSER :
		    WEBKIT_CACHE_MODEL_DOCUMENT_VIEWER);

		/* Currently only works with text file to be compatible with curl */
		webkit_cookie_manager_set_persistent_storage(
		    webkit_web_context_get_cookie_manager(context), cookiefile,
		    WEBKIT_COOKIE_PERSISTENT_STORAGE_TEXT);
		/* cookie policy */
		webkit_cookie_manager_set_accept_policy(
		    webkit_web_context_get_cookie_manager(context),
		    cookiepolicy_get());
		/* languages */
		webkit_web_context_set_preferred_languages(context,
		    curconfig[PreferredLanguages].val.v);
		webkit_web_context_set_spell_checking_languages(context,
		    curconfig[SpellLanguages].val.v);
		webkit_web_context_set_spell_checking_enabled(context,
		    curconfig[SpellChecking].val.b);

		g_signal_connect(G_OBJECT(context), "download-started",
		                 G_CALLBACK(downloadstarted), c);
		g_signal_connect(G_OBJECT(context), "initialize-web-extensions",
		                 G_CALLBACK(initwebextensions), c);

		v = g_object_new(WEBKIT_TYPE_WEB_VIEW,
		    "settings", settings,
		    "user-content-manager", contentmanager,
		    "web-context", context,
		    NULL);
	}

	g_signal_connect(G_OBJECT(v), "notify::estimated-load-progress",
			 G_CALLBACK(progresschanged), c);
	g_signal_connect(G_OBJECT(v), "notify::title",
			 G_CALLBACK(titlechanged), c);
	g_signal_connect(G_OBJECT(v), "button-release-event",
			 G_CALLBACK(buttonreleased), c);
	g_signal_connect(G_OBJECT(v), "close",
			G_CALLBACK(closeview), c);
	g_signal_connect(G_OBJECT(v), "create",
			 G_CALLBACK(createview), c);
	g_signal_connect(G_OBJECT(v), "decide-policy",
			 G_CALLBACK(decidepolicy), c);
	g_signal_connect(G_OBJECT(v), "load-changed",
			 G_CALLBACK(loadchanged), c);
	g_signal_connect(G_OBJECT(v), "mouse-target-changed",
			 G_CALLBACK(mousetargetchanged), c);
	g_signal_connect(G_OBJECT(v), "permission-request",
			 G_CALLBACK(permissionrequested), c);
	g_signal_connect(G_OBJECT(v), "ready-to-show",
			 G_CALLBACK(showview), c);

	return v;
}

void
initwebextensions(WebKitWebContext *wc, Client *c)
{
	webkit_web_context_set_web_extensions_directory(wc, WEBEXTDIR);
}

GtkWidget *
createview(WebKitWebView *v, WebKitNavigationAction *a, Client *c)
{
	Client *n;

	switch (webkit_navigation_action_get_navigation_type(a)) {
	case WEBKIT_NAVIGATION_TYPE_OTHER: /* fallthrough */
		/*
		 * popup windows of type “other” are almost always triggered
		 * by user gesture, so inverse the logic here
		 */
/* instead of this, compare destination uri to mouse-over uri for validating window */
		if (webkit_navigation_action_is_user_gesture(a))
			return NULL;
	case WEBKIT_NAVIGATION_TYPE_LINK_CLICKED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_SUBMITTED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_BACK_FORWARD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_RELOAD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_RESUBMITTED:
		n = newclient(c);
		break;
	default:
		return NULL;
	}

	return GTK_WIDGET(n->view);
}

gboolean
buttonreleased(GtkWidget *w, GdkEvent *e, Client *c)
{
	WebKitHitTestResultContext element;
	int i;

	element = webkit_hit_test_result_get_context(c->mousepos);

	for (i = 0; i < LENGTH(buttons); ++i) {
		if (element & buttons[i].target &&
		    e->button.button == buttons[i].button &&
		    CLEANMASK(e->button.state) == CLEANMASK(buttons[i].mask) &&
		    buttons[i].func) {
			buttons[i].func(c, &buttons[i].arg, c->mousepos);
			return buttons[i].stopevent;
		}
	}

	return FALSE;
}

GdkFilterReturn
processx(GdkXEvent *e, GdkEvent *event, gpointer d)
{
	Client *c = (Client *)d;
	XPropertyEvent *ev;
	Arg a;

	if (((XEvent *)e)->type == PropertyNotify) {
		ev = &((XEvent *)e)->xproperty;
		if (ev->state == PropertyNewValue) {
			if (ev->atom == atoms[AtomFind]) {
				find(c, NULL);

				return GDK_FILTER_REMOVE;
			} else if (ev->atom == atoms[AtomGo]) {
				a.v = getatom(c, AtomGo);
				loaduri(c, &a);

				return GDK_FILTER_REMOVE;
			}
		}
	}
	return GDK_FILTER_CONTINUE;
}

gboolean
winevent(GtkWidget *w, GdkEvent *e, Client *c)
{
	int i;

	switch (e->type) {
	case GDK_ENTER_NOTIFY:
		c->overtitle = c->targeturi;
		updatetitle(c);
		break;
	case GDK_KEY_PRESS:
		if (!curconfig[KioskMode].val.b) {
			for (i = 0; i < LENGTH(keys); ++i) {
				if (gdk_keyval_to_lower(e->key.keyval) ==
				    keys[i].keyval &&
				    CLEANMASK(e->key.state) == keys[i].mod &&
				    keys[i].func) {
					updatewinid(c);
					keys[i].func(c, &(keys[i].arg));
					return TRUE;
				}
			}
		}
	case GDK_LEAVE_NOTIFY:
		c->overtitle = NULL;
		updatetitle(c);
		break;
	case GDK_WINDOW_STATE:
		if (e->window_state.changed_mask ==
		    GDK_WINDOW_STATE_FULLSCREEN)
			c->fullscreen = e->window_state.new_window_state &
			                GDK_WINDOW_STATE_FULLSCREEN;
		break;
	default:
		break;
	}

	return FALSE;
}

void
showview(WebKitWebView *v, Client *c)
{
	GdkRGBA bgcolor = { 0 };
	GdkWindow *gwin;

	c->finder = webkit_web_view_get_find_controller(c->view);
	c->inspector = webkit_web_view_get_inspector(c->view);

	c->win = createwindow(c);

	gtk_container_add(GTK_CONTAINER(c->win), GTK_WIDGET(c->view));
	gtk_widget_show_all(c->win);
	gtk_widget_grab_focus(GTK_WIDGET(c->view));

	gwin = gtk_widget_get_window(GTK_WIDGET(c->win));
	c->xid = gdk_x11_window_get_xid(gwin);
	updatewinid(c);
	if (showxid) {
		gdk_display_sync(gtk_widget_get_display(c->win));
		puts(winid);
	}

	if (curconfig[HideBackground].val.b)
		webkit_web_view_set_background_color(c->view, &bgcolor);

	if (!curconfig[KioskMode].val.b) {
		gdk_window_set_events(gwin, GDK_ALL_EVENTS_MASK);
		gdk_window_add_filter(gwin, processx, c);
	}

	if (curconfig[RunInFullscreen].val.b)
		togglefullscreen(c, NULL);

	if (curconfig[ZoomLevel].val.f != 1.0)
		webkit_web_view_set_zoom_level(c->view,
		                               curconfig[ZoomLevel].val.f);

	setatom(c, AtomFind, "");
	setatom(c, AtomUri, "about:blank");
}

GtkWidget *
createwindow(Client *c)
{
	char *wmstr;
	GtkWidget *w;

	if (embed) {
		w = gtk_plug_new(embed);
	} else {
		w = gtk_window_new(GTK_WINDOW_TOPLEVEL);

		wmstr = g_path_get_basename(argv0);
		gtk_window_set_wmclass(GTK_WINDOW(w), wmstr, "Surf");
		g_free(wmstr);

		wmstr = g_strdup_printf("%s[%lu]", "Surf",
		        webkit_web_view_get_page_id(c->view));
		gtk_window_set_role(GTK_WINDOW(w), wmstr);
		g_free(wmstr);

		gtk_window_set_default_size(GTK_WINDOW(w), 800, 600);
	}

	g_signal_connect(G_OBJECT(w), "destroy",
	                 G_CALLBACK(destroywin), c);
	g_signal_connect(G_OBJECT(w), "enter-notify-event",
	                 G_CALLBACK(winevent), c);
	g_signal_connect(G_OBJECT(w), "key-press-event",
	                 G_CALLBACK(winevent), c);
	g_signal_connect(G_OBJECT(w), "leave-notify-event",
	                 G_CALLBACK(winevent), c);
	g_signal_connect(G_OBJECT(w), "window-state-event",
	                 G_CALLBACK(winevent), c);

	return w;
}

void
loadchanged(WebKitWebView *v, WebKitLoadEvent e, Client *c)
{
	const char *title = geturi(c);

	switch (e) {
	case WEBKIT_LOAD_STARTED:
		curconfig = defconfig;
		setatom(c, AtomUri, title);
		c->title = title;
		c->tlsflags = G_TLS_CERTIFICATE_VALIDATE_ALL + 1;
		seturiparameters(c, geturi(c));
		break;
	case WEBKIT_LOAD_REDIRECTED:
		setatom(c, AtomUri, title);
		c->title = title;
		seturiparameters(c, geturi(c));
		break;
	case WEBKIT_LOAD_COMMITTED:
		if (!webkit_web_view_get_tls_info(c->view, NULL,
		    &(c->tlsflags)))
			c->tlsflags = G_TLS_CERTIFICATE_VALIDATE_ALL + 1;

		break;
	case WEBKIT_LOAD_FINISHED:
		/* Disabled until we write some WebKitWebExtension for
		 * manipulating the DOM directly.
		evalscript(c, "document.documentElement.style.overflow = '%s'",
		    enablescrollbars ? "auto" : "hidden");
		*/
		runscript(c);
		break;
	}
	updatetitle(c);
}

void
progresschanged(WebKitWebView *v, GParamSpec *ps, Client *c)
{
	c->progress = webkit_web_view_get_estimated_load_progress(c->view) *
	              100;
	updatetitle(c);
}

void
titlechanged(WebKitWebView *view, GParamSpec *ps, Client *c)
{
	c->title = webkit_web_view_get_title(c->view);
	updatetitle(c);
}

void
mousetargetchanged(WebKitWebView *v, WebKitHitTestResult *h, guint modifiers,
    Client *c)
{
	WebKitHitTestResultContext hc = webkit_hit_test_result_get_context(h);

	/* Keep the hit test to know where is the pointer on the next click */
	c->mousepos = h;

	if (hc & OnLink)
		c->targeturi = webkit_hit_test_result_get_link_uri(h);
	else if (hc & OnImg)
		c->targeturi = webkit_hit_test_result_get_image_uri(h);
	else if (hc & OnMedia)
		c->targeturi = webkit_hit_test_result_get_media_uri(h);
	else
		c->targeturi = NULL;

	c->overtitle = c->targeturi;
	updatetitle(c);
}

gboolean
permissionrequested(WebKitWebView *v, WebKitPermissionRequest *r, Client *c)
{
	if (WEBKIT_IS_GEOLOCATION_PERMISSION_REQUEST(r)) {
		if (curconfig[Geolocation].val.b)
			webkit_permission_request_allow(r);
		else
			webkit_permission_request_deny(r);
		return TRUE;
	}

	return FALSE;
}

gboolean
decidepolicy(WebKitWebView *v, WebKitPolicyDecision *d,
    WebKitPolicyDecisionType dt, Client *c)
{
	switch (dt) {
	case WEBKIT_POLICY_DECISION_TYPE_NAVIGATION_ACTION:
		decidenavigation(d, c);
		break;
	case WEBKIT_POLICY_DECISION_TYPE_NEW_WINDOW_ACTION:
		decidenewwindow(d, c);
		break;
	case WEBKIT_POLICY_DECISION_TYPE_RESPONSE:
		decideresource(d, c);
		break;
	default:
		webkit_policy_decision_ignore(d);
		break;
	}
	return TRUE;
}

void
decidenavigation(WebKitPolicyDecision *d, Client *c)
{
	WebKitNavigationAction *a =
	    webkit_navigation_policy_decision_get_navigation_action(
	    WEBKIT_NAVIGATION_POLICY_DECISION(d));

	switch (webkit_navigation_action_get_navigation_type(a)) {
	case WEBKIT_NAVIGATION_TYPE_LINK_CLICKED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_SUBMITTED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_BACK_FORWARD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_RELOAD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_RESUBMITTED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_OTHER: /* fallthrough */
	default:
		/* Do not navigate to links with a "_blank" target (popup) */
		if (webkit_navigation_policy_decision_get_frame_name(
		    WEBKIT_NAVIGATION_POLICY_DECISION(d))) {
			webkit_policy_decision_ignore(d);
		} else {
			/* Filter out navigation to different domain ? */
			/* get action→urirequest, copy and load in new window+view
			 * on Ctrl+Click ? */
			webkit_policy_decision_use(d);
		}
		break;
	}
}

void
decidenewwindow(WebKitPolicyDecision *d, Client *c)
{
	Arg arg;
	WebKitNavigationAction *a =
	    webkit_navigation_policy_decision_get_navigation_action(
	    WEBKIT_NAVIGATION_POLICY_DECISION(d));


	switch (webkit_navigation_action_get_navigation_type(a)) {
	case WEBKIT_NAVIGATION_TYPE_LINK_CLICKED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_SUBMITTED: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_BACK_FORWARD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_RELOAD: /* fallthrough */
	case WEBKIT_NAVIGATION_TYPE_FORM_RESUBMITTED:
		/* Filter domains here */
/* If the value of “mouse-button” is not 0, then the navigation was triggered by a mouse event.
 * test for link clicked but no button ? */
		arg.v = webkit_uri_request_get_uri(
		        webkit_navigation_action_get_request(a));
		newwindow(c, &arg, 0);
		break;
	case WEBKIT_NAVIGATION_TYPE_OTHER: /* fallthrough */
	default:
		break;
	}

	webkit_policy_decision_ignore(d);
}

void
decideresource(WebKitPolicyDecision *d, Client *c)
{
	int i, isascii = 1;
	WebKitResponsePolicyDecision *r = WEBKIT_RESPONSE_POLICY_DECISION(d);
	WebKitURIResponse *res =
	    webkit_response_policy_decision_get_response(r);
	const gchar *uri = webkit_uri_response_get_uri(res);

	if (g_str_has_suffix(uri, "/favicon.ico")) {
		webkit_policy_decision_ignore(d);
		return;
	}

	if (!g_str_has_prefix(uri, "http://")
	    && !g_str_has_prefix(uri, "https://")
	    && !g_str_has_prefix(uri, "about:")
	    && !g_str_has_prefix(uri, "file://")
	    && !g_str_has_prefix(uri, "data:")
	    && !g_str_has_prefix(uri, "blob:")
	    && strlen(uri) > 0) {
		for (i = 0; i < strlen(uri); i++) {
			if (!g_ascii_isprint(uri[i])) {
				isascii = 0;
				break;
			}
		}
		if (isascii) {
			handleplumb(c, uri);
			webkit_policy_decision_ignore(d);
			return;
		}
	}

	if (webkit_response_policy_decision_is_mime_type_supported(r)) {
		webkit_policy_decision_use(d);
	} else {
		webkit_policy_decision_ignore(d);
		download(c, res);
	}
}

void
downloadstarted(WebKitWebContext *wc, WebKitDownload *d, Client *c)
{
	g_signal_connect(G_OBJECT(d), "notify::response",
	                 G_CALLBACK(responsereceived), c);
}

void
responsereceived(WebKitDownload *d, GParamSpec *ps, Client *c)
{
	download(c, webkit_download_get_response(d));
	webkit_download_cancel(d);
}

void
download(Client *c, WebKitURIResponse *r)
{
	Arg a = (Arg)DOWNLOAD(webkit_uri_response_get_uri(r), geturi(c));
	spawn(c, &a);
}

void
closeview(WebKitWebView *v, Client *c)
{
	gtk_widget_destroy(c->win);
}

void
destroywin(GtkWidget* w, Client *c)
{
	destroyclient(c);
	if (!clients)
		gtk_main_quit();
}

void
pasteuri(GtkClipboard *clipboard, const char *text, gpointer d)
{
	Arg a = {.v = text };
	if (text)
		loaduri((Client *) d, &a);
}

void
reload(Client *c, const Arg *a)
{
	if (a->b)
		webkit_web_view_reload_bypass_cache(c->view);
	else
		webkit_web_view_reload(c->view);
}

void
print(Client *c, const Arg *a)
{
	webkit_print_operation_run_dialog(webkit_print_operation_new(c->view),
	                                  GTK_WINDOW(c->win));
}

void
clipboard(Client *c, const Arg *a)
{
	if (a->b) { /* load clipboard uri */
		gtk_clipboard_request_text(gtk_clipboard_get(
		                           GDK_SELECTION_CLIPBOARD),
		                           pasteuri, c);
	} else { /* copy uri */
		gtk_clipboard_set_text(gtk_clipboard_get(
		                       GDK_SELECTION_CLIPBOARD), c->targeturi
		                       ? c->targeturi : geturi(c), -1);
	}
}

void
zoom(Client *c, const Arg *a)
{
	if (a->i > 0)
		webkit_web_view_set_zoom_level(c->view,
		                               curconfig[ZoomLevel].val.f + 0.1);
	else if (a->i < 0)
		webkit_web_view_set_zoom_level(c->view,
		                               curconfig[ZoomLevel].val.f - 0.1);
	else
		webkit_web_view_set_zoom_level(c->view, 1.0);

	curconfig[ZoomLevel].val.f = webkit_web_view_get_zoom_level(c->view);
}

void
scroll(Client *c, const Arg *a)
{
	GdkEvent *ev = gdk_event_new(GDK_KEY_PRESS);

	gdk_event_set_device(ev, gdkkb);
	ev->key.window = gtk_widget_get_window(GTK_WIDGET(c->win));
	ev->key.state = GDK_CONTROL_MASK;
	ev->key.time = GDK_CURRENT_TIME;

	switch (a->i) {
	case 'd':
		ev->key.keyval = GDK_KEY_Down;
		break;
	case 'D':
		ev->key.keyval = GDK_KEY_Page_Down;
		break;
	case 'l':
		ev->key.keyval = GDK_KEY_Left;
		break;
	case 'r':
		ev->key.keyval = GDK_KEY_Right;
		break;
	case 'U':
		ev->key.keyval = GDK_KEY_Page_Up;
		break;
	case 'u':
		ev->key.keyval = GDK_KEY_Up;
		break;
	}

	gdk_event_put(ev);
}

void
navigate(Client *c, const Arg *a)
{
	if (a->i < 0)
		webkit_web_view_go_back(c->view);
	else if (a->i > 0)
		webkit_web_view_go_forward(c->view);
}

void
stop(Client *c, const Arg *a)
{
	webkit_web_view_stop_loading(c->view);
}

void
toggle(Client *c, const Arg *a)
{
	curconfig[a->i].val.b ^= 1;
	setparameter(c, 1, (ParamName)a->i, &curconfig[a->i].val);
}

void
togglefullscreen(Client *c, const Arg *a)
{
	/* toggling value is handled in winevent() */
	if (c->fullscreen)
		gtk_window_unfullscreen(GTK_WINDOW(c->win));
	else
		gtk_window_fullscreen(GTK_WINDOW(c->win));
}

void
togglecookiepolicy(Client *c, const Arg *a)
{
	++cookiepolicy;
	cookiepolicy %= strlen(curconfig[CookiePolicies].val.v);

	setparameter(c, 0, CookiePolicies, NULL);
}

void
toggleinspector(Client *c, const Arg *a)
{
	if (webkit_web_inspector_is_attached(c->inspector))
		webkit_web_inspector_close(c->inspector);
	else if (curconfig[Inspector].val.b)
		webkit_web_inspector_show(c->inspector);
}

void
find(Client *c, const Arg *a)
{
	const char *s, *f;

	if (a && a->i) {
		if (a->i > 0)
			webkit_find_controller_search_next(c->finder);
		else
			webkit_find_controller_search_previous(c->finder);
	} else {
		s = getatom(c, AtomFind);
		f = webkit_find_controller_get_search_text(c->finder);

		if (g_strcmp0(f, s) == 0) /* reset search */
			webkit_find_controller_search(c->finder, "", findopts,
			                              G_MAXUINT);

		webkit_find_controller_search(c->finder, s, findopts,
		                              G_MAXUINT);

		if (strcmp(s, "") == 0)
			webkit_find_controller_search_finish(c->finder);
	}
}

void
clicknavigate(Client *c, const Arg *a, WebKitHitTestResult *h)
{
	navigate(c, a);
}

void
clicknewwindow(Client *c, const Arg *a, WebKitHitTestResult *h)
{
	Arg arg;

	arg.v = webkit_hit_test_result_get_link_uri(h);
	newwindow(c, &arg, a->b);
}

void
clickexternplayer(Client *c, const Arg *a, WebKitHitTestResult *h)
{
	Arg arg;

	arg = (Arg)VIDEOPLAY(webkit_hit_test_result_get_media_uri(h));
	spawn(c, &arg);
}

int
main(int argc, char *argv[])
{
	Arg arg;
	Client *c;

	memset(&arg, 0, sizeof(arg));

	/* command line args */
	ARGBEGIN {
	case 'a':
		defconfig CSETV(CookiePolicies, EARGF(usage()));
		break;
	case 'b':
		defconfig CSETB(ScrollBars, 0);
		break;
	case 'B':
		defconfig CSETB(ScrollBars, 1);
		break;
	case 'c':
		cookiefile = EARGF(usage());
		break;
	case 'd':
		defconfig CSETB(DiskCache, 0);
		break;
	case 'D':
		defconfig CSETB(DiskCache, 1);
		break;
	case 'e':
		embed = strtol(EARGF(usage()), NULL, 0);
		break;
	case 'f':
		defconfig CSETB(RunInFullscreen, 0);
		break;
	case 'F':
		defconfig CSETB(RunInFullscreen, 1);
		break;
	case 'g':
		defconfig CSETB(Geolocation, 0);
		break;
	case 'G':
		defconfig CSETB(Geolocation, 1);
		break;
	case 'i':
		defconfig CSETB(LoadImages, 0);
		break;
	case 'I':
		defconfig CSETB(LoadImages, 1);
		break;
	case 'k':
		defconfig CSETB(KioskMode, 0);
		break;
	case 'K':
		defconfig CSETB(KioskMode, 1);
		break;
	case 'm':
		defconfig CSETB(Style, 0);
		break;
	case 'M':
		defconfig CSETB(Style, 1);
		break;
	case 'n':
		defconfig CSETB(Inspector, 0);
		break;
	case 'N':
		defconfig CSETB(Inspector, 1);
		break;
	case 'p':
		defconfig CSETB(Plugins, 0);
		break;
	case 'P':
		defconfig CSETB(Plugins, 1);
		break;
	case 'r':
		scriptfile = EARGF(usage());
		break;
	case 's':
		defconfig CSETB(JavaScript, 0);
		break;
	case 'S':
		defconfig CSETB(JavaScript, 1);
		break;
	case 't':
		stylefile = EARGF(usage());
		break;
	case 'u':
		fulluseragent = EARGF(usage());
		break;
	case 'v':
		die("surf-"VERSION", ©2009-2015 surf engineers, "
		    "see LICENSE for details\n");
	case 'x':
		showxid = 1;
		break;
	case 'z':
		defconfig CSETF(ZoomLevel, strtof(EARGF(usage()), NULL));
		break;
	default:
		usage();
	} ARGEND;
	if (argc > 0)
		arg.v = argv[0];
	else
		arg.v = "file:///home/jan/.local/share/startpage/index.html";

	setup();
	c = newclient(NULL);
	showview(NULL, c);

	loaduri(c, &arg);
	updatetitle(c);

	gtk_main();
	cleanup();

	return 0;
}
