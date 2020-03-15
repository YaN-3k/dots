/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]        = "-*-*-medium-*-*-*-14-*-*-*-*-*-*-*";
static const char* normbgcolor  = "#161821";
static const char* normfgcolor  = "#c6c8d1";
static const char* selbgcolor   = "#22262e";
static const char* selfgcolor   = "#84a0c6";
static const char before[]      = "<";
static const char after[]       = ">";
static const int  tabwidth      = 200;
static const Bool foreground    = True;

/*
 * Where to place a new tab when it is opened. When npisrelative is True,
 * then the current position is changed + newposition. If npisrelative
 * is False, then newposition is an absolute position.
 */
static int  newposition   = 0;
static Bool npisrelative  = False;

#define SETPROP(p) { \
	.v = (char *[]){ "/bin/sh", "-c", \
		"prop=\"`xwininfo -children -id $1 | grep '^     0x' | sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' | xargs -0 printf %b | dmenu -l 10`\" &&" \
		"xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
		p, winid, NULL \
	} \
}

#define ALT Mod1Mask
#define CTRL ControlMask
static Key keys[] = { \
	/* modifier                     key        function        argument */
	{ CTRL|ShiftMask,               XK_Return, focusonce,      { 0 } },
	{ CTRL|ShiftMask,               XK_Return, spawn,          { 0 } },
	{ CTRL,                         XK_t,      spawn,          SETPROP("_TABBED_SELECT_TAB") },

	{ CTRL|ShiftMask,               XK_l,      rotate,         { .i = +1 } },
	{ CTRL|ShiftMask,               XK_h,      rotate,         { .i = -1 } },
	{ CTRL|ShiftMask,               XK_k,      movetab,        { .i = -1 } },
	{ CTRL|ShiftMask,               XK_j,      movetab,        { .i = +1 } },
	{ CTRL,                         XK_Tab,    rotate,         { .i = 0 } },

	{ CTRL,                         XK_1,      move,           { .i = 0 } },
	{ CTRL,                         XK_2,      move,           { .i = 1 } },
	{ CTRL,                         XK_3,      move,           { .i = 2 } },
	{ CTRL,                         XK_4,      move,           { .i = 3 } },
	{ CTRL,                         XK_5,      move,           { .i = 4 } },
	{ CTRL,                         XK_6,      move,           { .i = 5 } },
	{ CTRL,                         XK_7,      move,           { .i = 6 } },
	{ CTRL,                         XK_8,      move,           { .i = 7 } },
	{ CTRL,                         XK_9,      move,           { .i = 8 } },
	{ CTRL,                         XK_0,      move,           { .i = 9 } },

	{ CTRL,                         XK_q,      killclient,     { 0 } },

	{ 0,                            XK_F11,    fullscreen,     { 0 } },
};

