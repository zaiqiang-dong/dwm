/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int minwsz    = 20;       /* Minimal heigt of a client for smfact */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;
/* "WenQuanYi Micro Hei:size=12:style=Bold" */
static const char *fonts[]          = {
                                        "Noto Sans CJK HK:style=Bold:size=12",
                                        "Hack Nerd Font Mono:style=Bold:size=14",
                                        "Symbola:style=Regular:size=14",
                                       };
static const char dmenufont[]       = "Hack Nerd Font Mono:size=13";
static const char col_gray1[]       = "#000000";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#239B56";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_cyan, col_gray1,  col_gray2 },
};

/* tagging */
static const char *tags[] = {"1","2","3","4","5","6"};

static const Rule rules[] = {
    /*
     * 这里仅仅是定义某个程序跑在那里，并不能真正的启动一个程序
     * 启动程序在scripts/dwm-start-tools.sh里配置
     */
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask     isfloating   monitor */
	{ "PigchaProxy",    NULL,       NULL,       1 << 5,       0,           0 },
	{ "D-Chat",         NULL,       NULL,       1 << 5,       0,           0 },
	{ "Google-chrome",  NULL,       NULL,       1 << 4,       0,           0 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const float smfact     = 0.00; /* factor of tiled clients [0.00..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[M]",      monocle },
	{ "[]=",      tile },    /* first entry is default */
};

/* key definitions */
#define MODKEY ControlMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|Mod1Mask,              KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|Mod1Mask|ShiftMask,    KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-no-lazy-grab", "-show" , "drun", "-modi", "run,drun,window", "-theme", "~/.config/rofi/theme/style_7.rasi", NULL};
static const char *termcmd[]  = { "st", NULL };
//static const char *slockcmd[]  = { "slock", NULL };
//static const char *slockcmd[]  = { "i3lock", "-c", "000000", "-e", "&&", "xset", "dpms", "force", "off", NULL};
static const char *slockcmd[]  = { "dwm-lock", NULL };
static const char *flameshotcmd[]  = { "flameshot", "gui", NULL };
static const char *shutdowncmd[]  = { "shutdown", "now", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ Mod1Mask,                     XK_minus,  spawn,          {.v = shutdowncmd} },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = flameshotcmd } },
	{ Mod1Mask,                     XK_period, spawn,          {.v = slockcmd } },
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,      setsmfact,      {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_k,      setsmfact,      {.f = -0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_w,      killclient,     {0} },
	{ Mod1Mask,                     XK_f,      fullscreen,     {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_m,      focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_comma,  focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  zoom,           {.i = -1 } },
    /* 移动一个窗口在两个屏幕上 */
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    { MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask|Mod1Mask,    XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[1]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY|ShiftMask,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

