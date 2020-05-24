From 53e56c751b3f2be4154760788850c51dbffc0add Mon Sep 17 00:00:00 2001
From: Arnas Udovicius <zordsdavini@gmail.com>
Date: Tue, 26 Nov 2019 16:16:15 +0200
Subject: [PATCH] Read colors from Xresources

---
 config.def.h | 14 +++++++++--
 slock.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 util.h       |  3 +++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/config.def.h b/config.def.h
index 6288856..bfc1ba0 100644
--- a/config.def.h
+++ b/config.def.h
@@ -3,11 +3,21 @@ static const char *user  = "nobody";
 static const char *group = "nogroup";
 
 static const char *colorname[NUMCOLS] = {
-	[INIT] =   "black",     /* after initialization */
-	[INPUT] =  "#005577",   /* during input */
+	[INIT] = "black",       /* after initialization */
+	[INPUT] = "#005577",    /* during input */
 	[FAILED] = "#CC3333",   /* wrong password */
 	[CAPS] = "red",         /* CapsLock on */
 };
 
+/*
+ * Xresources preferences to load at startup
+ */
+ResourcePref resources[] = {
+		{ "color0",       STRING,  &colorname[INIT] },
+		{ "color4",       STRING,  &colorname[INPUT] },
+		{ "color1",       STRING,  &colorname[FAILED] },
+		{ "color3",       STRING,  &colorname[CAPS] },
+};
+
 /* treat a cleared input like a wrong password (color) */
 static const int failonclear = 1;
diff --git a/slock.c b/slock.c
index 5f4fb7a..2395547 100644
--- a/slock.c
+++ b/slock.c
@@ -6,6 +6,7 @@
 
 #include <ctype.h>
 #include <errno.h>
+#include <math.h>
 #include <grp.h>
 #include <pwd.h>
 #include <stdarg.h>
@@ -19,6 +20,7 @@
 #include <X11/Xlib.h>
 #include <X11/Xutil.h>
 #include <X11/XKBlib.h>
+#include <X11/Xresource.h>
 
 #include "arg.h"
 #include "util.h"
@@ -46,6 +48,19 @@ struct xrandr {
 	int errbase;
 };
 
+/* Xresources preferences */
+enum resource_type {
+	STRING = 0,
+	INTEGER = 1,
+	FLOAT = 2
+};
+
+typedef struct {
+	char *name;
+	enum resource_type type;
+	void *dst;
+} ResourcePref;
+
 #include "config.h"
 
 static void
@@ -306,6 +321,57 @@ lockscreen(Display *dpy, struct xrandr *rr, int screen)
 	return NULL;
 }
 
+int
+resource_load(XrmDatabase db, char *name, enum resource_type rtype, void *dst)
+{
+	char **sdst = dst;
+	int *idst = dst;
+	float *fdst = dst;
+
+	char fullname[256];
+	char fullclass[256];
+	char *type;
+	XrmValue ret;
+
+	snprintf(fullname, sizeof(fullname), "%s.%s", "slock", name);
+	snprintf(fullclass, sizeof(fullclass), "%s.%s", "Slock", name);
+	fullname[sizeof(fullname) - 1] = fullclass[sizeof(fullclass) - 1] = '\0';
+
+	XrmGetResource(db, fullname, fullclass, &type, &ret);
+	if (ret.addr == NULL || strncmp("String", type, 64))
+		return 1;
+
+	switch (rtype) {
+	case STRING:
+		*sdst = ret.addr;
+		break;
+	case INTEGER:
+		*idst = strtoul(ret.addr, NULL, 10);
+		break;
+	case FLOAT:
+		*fdst = strtof(ret.addr, NULL);
+		break;
+	}
+	return 0;
+}
+
+void
+config_init(Display *dpy)
+{
+	char *resm;
+	XrmDatabase db;
+	ResourcePref *p;
+
+	XrmInitialize();
+	resm = XResourceManagerString(dpy);
+	if (!resm)
+		return;
+
+	db = XrmGetStringDatabase(resm);
+	for (p = resources; p < resources + LEN(resources); p++)
+		resource_load(db, p->name, p->type, p->dst);
+}
+
 static void
 usage(void)
 {
@@ -364,6 +430,8 @@ main(int argc, char **argv) {
 	if (setuid(duid) < 0)
 		die("slock: setuid: %s\n", strerror(errno));
 
+	config_init(dpy);
+
 	/* check for Xrandr support */
 	rr.active = XRRQueryExtension(dpy, &rr.evbase, &rr.errbase);
 
diff --git a/util.h b/util.h
index 6f748b8..148dbc1 100644
--- a/util.h
+++ b/util.h
@@ -1,2 +1,5 @@
+/* macros */
+#define LEN(a)			(sizeof(a) / sizeof(a)[0])
+
 #undef explicit_bzero
 void explicit_bzero(void *, size_t);
-- 
2.24.0

