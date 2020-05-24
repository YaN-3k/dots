/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 20;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Terminus:size=10", "Font Awesome 5 Free Solid:size=8" };
static const char dmenufont[]       = "Terminus:size=10";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class         instance    title       tags mask    iscentered    isfloating   monitor */
	{ "Gimp",        NULL,       NULL,       1 << 2,      0,            0,           -1 },
	{ "Firefox",     NULL,       NULL,       1 << 2,      0,            0,           -1 },
	{ "qutebrowser", NULL,       NULL,       1 << 2,      0,            0,           -1 },
	{ "Telegram",    NULL,       NULL,       1 << 3,      0,            0,           -1 },
	{ "discord",     NULL,       NULL,       1 << 3,      0,            0,           -1 },
	{ NULL,       "float",       NULL,            0,      1,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "|  T",      tile },    /* first entry is default */
	{ "|  M",      monocle },
	{ "|  F",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \
	{ MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \
	/*{ MOD, XK_f,     ACTION##stack, {.i = 0 } },*/
	/*{ MOD, XK_x,     ACTION##stack, {.i = -1 } },*/

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-w", "245", "-x", "10", "-y", "30" };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_b,      togglebar,      {0} },

  /* realod colorscheme */
	{ MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },

	/* layouts */
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_space,  zoom,           {0} },

	/* window managment */
	STACKKEYS(MODKEY,                          focus)
	STACKKEYS(MODKEY|ShiftMask,                push)

	{ MODKEY|ControlMask,           XK_j,      shiftview,      {.i = +1 } },
  { MODKEY|ControlMask,           XK_k,      shiftview,      {.i = -1 } },

	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },

	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },

	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },

	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },

	/* monitors */
	{ MODKEY,                       XK_Left,   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_Right,  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right,  tagmon,         {.i = +1 } },

	/* gaps */
	{ MODKEY|ControlMask,           XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY|ControlMask,           XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ControlMask,           XK_0,      setgaps,        {.i = 0  } },

	/* programs */
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },

	{ ALTKEY,                       XK_f,      spawn,          SHCMD("st -e vifmrun") },
	{ ALTKEY,                       XK_m,      spawn,          SHCMD("st -n float -e ncmpcpp") },
	{ ALTKEY,                       XK_v,      spawn,          SHCMD("st -e nvim") },
	{ ALTKEY,                       XK_a,      spawn,          SHCMD("st -e alsamixer") },
	{ ALTKEY,                       XK_e,      spawn,          SHCMD("st -e neomutt") },
	{ ALTKEY|ShiftMask,             XK_e,      spawn,          SHCMD("st -n newsboat -e rss") },
	{ ALTKEY,                       XK_w,      spawn,          SHCMD("qutebrowser") },

	/* scripts */
	{ MODKEY|ControlMask,           XK_e,      spawn,          SHCMD("prompt 'Leave Xorg?' 'killall Xorg'") },
	{ MODKEY|ControlMask,           XK_q,      spawn,          SHCMD("prompt 'Shutdown computer?' 'shutdown -h now'") },
	{ MODKEY|ControlMask,           XK_x,      spawn,          SHCMD("prompt 'Lock screen' 'slock & mpc pause'") },
	{ MODKEY|ControlMask,           XK_BackSpace, spawn,       SHCMD("prompt 'Reboot computer?' 'reboot'") },

	{ MODKEY|ControlMask,           XK_i,      spawn,          SHCMD("dmenuunicode") },
	{ MODKEY|ControlMask,           XK_o,      spawn,          SHCMD("dmenunewtab") },
	{ MODKEY|ControlMask,           XK_n,      spawn,          SHCMD("dmenuiwd") },
	{ MODKEY|ControlMask,           XK_m,      spawn,          SHCMD("dmenumount") },
	{ MODKEY|ControlMask,           XK_u,      spawn,          SHCMD("dmenuumount") },
	{ MODKEY|ControlMask,           XK_t,      spawn,          SHCMD("dmenutmux") },
	{ MODKEY,                       XK_End,    spawn,          SHCMD("dmenuscreen") },
	{ MODKEY,                       XK_Insert, spawn,          SHCMD("showclip") },
	{ MODKEY,                       XK_Escape, spawn,          SHCMD("dmenupower") },
	{ MODKEY|ControlMask,           XK_Insert, spawn,          SHCMD("blaze") },
	{ MODKEY|ControlMask,           XK_w,      spawn,          SHCMD("blaze -s") },
	{ MODKEY|ControlMask,           XK_Delete, spawn,          SHCMD("dmenureload") },
	{ MODKEY|ControlMask|ShiftMask, XK_u,      spawn,          SHCMD("update") },
	{ MODKEY|ControlMask,           XK_p,      spawn,          SHCMD("passmenu2 --type") },

	/* media */
	{ MODKEY|ShiftMask,             XK_m,      spawn,          SHCMD("amixer sset Master toggle") },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          SHCMD("mpc toggle") },

	{ MODKEY,                       XK_comma,  spawn,          SHCMD("mpc prev; dunstify \"$(mpc current)\"") },
	{ MODKEY|ShiftMask,             XK_comma,  spawn,          SHCMD("mpc seek 0%") },
	{ MODKEY,                       XK_period, spawn,          SHCMD("mpc next; dunstify \"$(mpc current)\"") },
	{ MODKEY|ShiftMask,             XK_period, spawn,          SHCMD("mpc repeat")  },

	{ MODKEY,                       XK_bracketleft,    spawn,  SHCMD("mpc seek -10") },
	{ MODKEY|ShiftMask,             XK_bracketleft,    spawn,  SHCMD("mpc seek -60") },
	{ MODKEY,                       XK_bracketright,   spawn,  SHCMD("mpc seek +10") },
	{ MODKEY|ShiftMask,             XK_bracketright,   spawn,  SHCMD("mpc seek +60") },

	/* volume */
	{ MODKEY,                       XK_equal,  spawn,          SHCMD("volume alsa up")   },
	{ MODKEY|ShiftMask,             XK_equal,  spawn,          SHCMD("volume mpc up")  },
	{ MODKEY,                       XK_minus,  spawn,          SHCMD("volume alsa down") },
	{ MODKEY|ShiftMask,             XK_minus,  spawn,          SHCMD("volume mpc down")  },

	/* backlight */
	{ ALTKEY,                       XK_equal,  spawn,          SHCMD("brightness up")   },
	{ ALTKEY|ShiftMask,             XK_equal,  spawn,          SHCMD("keybacklight -inc")  },
	{ ALTKEY,                       XK_minus,  spawn,          SHCMD("brightness down") },
	{ ALTKEY|ShiftMask,             XK_minus,  spawn,          SHCMD("keybacklight -dec")  },

	/* workspaces */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	/*{ MODKEY|ShiftMask,             XK_BackSpace, quit,        {0} },*/
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

void
setlayoutex(const Arg *arg)
{
	setlayout(&((Arg) { .v = &layouts[arg->i] }));
}

void
viewex(const Arg *arg)
{
	view(&((Arg) { .ui = 1 << arg->ui }));
}

void
viewall(const Arg *arg)
{
	view(&((Arg){.ui = ~0}));
}

void
toggleviewex(const Arg *arg)
{
	toggleview(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagex(const Arg *arg)
{
	tag(&((Arg) { .ui = 1 << arg->ui }));
}

void
toggletagex(const Arg *arg)
{
	toggletag(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagall(const Arg *arg)
{
	tag(&((Arg){.ui = ~0}));
}

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signame> [<type> <value>]"` */
static Signal signals[] = {
	/* signum           function */
	{ "focusstack",     focusstack },
	{ "setmfact",       setmfact },
	{ "togglebar",      togglebar },
	{ "incnmaster",     incnmaster },
	{ "togglefloating", togglefloating },
	{ "focusmon",       focusmon },
	{ "tagmon",         tagmon },
	{ "zoom",           zoom },
	{ "view",           view },
	{ "viewall",        viewall },
	{ "viewex",         viewex },
	{ "toggleview",     view },
	{ "toggleviewex",   toggleviewex },
	{ "tag",            tag },
	{ "tagall",         tagall },
	{ "tagex",          tagex },
	{ "toggletag",      tag },
	{ "toggletagex",    toggletagex },
	{ "killclient",     killclient },
	{ "quit",           quit },
	{ "setlayout",      setlayout },
	{ "setlayoutex",    setlayoutex },
};
