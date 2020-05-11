From 3a16816a6f5d38014c2a06ce395873c545c8789a Mon Sep 17 00:00:00 2001
From: Soenke Lambert <s.lambert@mittwald.de>
Date: Tue, 12 Nov 2019 10:44:02 +0100
Subject: [PATCH] Fullscreen current window with [Alt]+[Shift]+[f]

This actually fullscreens a window, instead of just hiding the statusbar
and applying the monocle layout.
---
 config.def.h | 1 +
 dwm.c        | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/config.def.h b/config.def.h
index 1c0b587..8cd3204 100644
--- a/config.def.h
+++ b/config.def.h
@@ -78,6 +78,7 @@ static Key keys[] = {
 	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
 	{ MODKEY,                       XK_space,  setlayout,      {0} },
 	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
+	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
 	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
 	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
 	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
diff --git a/dwm.c b/dwm.c
index 4465af1..c1b899a 100644
--- a/dwm.c
+++ b/dwm.c
@@ -211,6 +211,7 @@ static void tagmon(const Arg *arg);
 static void tile(Monitor *);
 static void togglebar(const Arg *arg);
 static void togglefloating(const Arg *arg);
+static void togglefullscr(const Arg *arg);
 static void toggletag(const Arg *arg);
 static void toggleview(const Arg *arg);
 static void unfocus(Client *c, int setfocus);
@@ -1719,6 +1720,13 @@ togglefloating(const Arg *arg)
 	arrange(selmon);
 }
 
+void
+togglefullscr(const Arg *arg)
+{
+  if(selmon->sel)
+    setfullscreen(selmon->sel, !selmon->sel->isfullscreen);
+}
+
 void
 toggletag(const Arg *arg)
 {
-- 
2.17.1

