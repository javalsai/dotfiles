import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import Data.Monoid
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-----------------------------------------------------------------------
----------------------- Global Config Variables -----------------------
-----------------------------------------------------------------------
-- Default Applications
myTerminal      =  "alacritty"
myBrowser       =  "firefox"
myExplorer      =  "dolphin"

-- Mouse Behaviour
myFocusFollowsMouse     =  False
myClickJustFocuses      =  False

-- Key bindings
myModMask               =  mod4Mask

-- Workspaces
myWorkspaces            =  ["Ter","Int","Mus","Alt-1","Soc","Gam","Hig","Aca","Alt-2"]

-- Window Borders
myBorderWidth           =  3
myNormalBorderColor     =  "#DD9944"
myFocusedBorderColor    =  "#DD5555"


-----------------------------------------------------------------------
-------- Key bindings. Add, modify or remove key bindings here --------
-----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
    --- Use Shortcuts ---
    ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
    ((modm              , xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\""),
    ((modm .|. shiftMask, xK_p     ), spawn "gmrun"),
    ((modm .|. shiftMask, xK_c     ), kill),
    ((modm              , xK_space ), sendMessage NextLayout),
    ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf),
    ((modm              , xK_n     ), refresh),

    --- Focus Windows ---
    ((mod1Mask          , xK_Tab   ), windows W.focusDown),
    ((modm              , xK_j     ), windows W.focusDown),
    ((modm              , xK_k     ), windows W.focusUp  ),
    ((modm              , xK_m     ), windows W.focusMaster  ),
    ((modm              , xK_Return), windows W.swapMaster),

    -- Swap Focused Windows --
    ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ),
    ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ),

    --- Windows Sizes and Positions ---
    ((modm              , xK_h     ), sendMessage Shrink),
    ((modm              , xK_l     ), sendMessage Expand),
    ((modm              , xK_t     ), withFocused $ windows . W.sink),

    -- Number of Windows in Master Area --
    ((modm              , xK_comma ), sendMessage (IncMasterN 1)),
    ((modm              , xK_period), sendMessage (IncMasterN (-1))),

    --- Direct XMonad Stuff ---
    ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)),
    ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart"),

    --- Xrandr Brightness ---
    ((modm .|. shiftMask, xK_m     ), spawn "DISPLAY=:0 xrandr --output HDMI-A-0 --brightness $(($(xrandr --verbose | grep -i brightness | cut -f2 -d ' ' | head -n1) + .1))"),
    ((modm .|. shiftMask, xK_n     ), spawn "DISPLAY=:0 xrandr --output HDMI-A-0 --brightness $(($(xrandr --verbose | grep -i brightness | cut -f2 -d ' ' | head -n1) - .1))")
    ]
    ++

    --- Workspaces ---
      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --- Xinerama ---
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-----------------------------------------------------------------------
-------- Mouse bindings: default actions bound to mouse events --------
-----------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $ [
    ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster)),
    
    ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),

    ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster))
    ]

-----------------------------------------------------------------------
------------------------------- Layouts -------------------------------
-----------------------------------------------------------------------

myLayout = smartBorders tiled ||| Mirror tiled ||| noBorders Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
    `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),

      -- https://github.com/freedesktop/xorg-x11proto/blob/master/XF86keysym.h
      -- 0x1008FF11: <XF86XK_AudioLowerVolume>
      ((0                          , 0x1008FF11), spawn "amixer -q sset Master 5%-"),
      ((controlMask                , 0x1008FF11), spawn "amixer -q sset Master 10%-"),
      ((shiftMask                  , 0x1008FF11), spawn "amixer -q sset Master 2%-"),

      -- 0x1008FF13: <XF86XK_AudioRaiseVolume>
      ((0                          , 0x1008FF13), spawn "amixer -q sset Master 5%+"),
      ((controlMask                , 0x1008FF13), spawn "amixer -q sset Master 10%+"),
      ((shiftMask                  , 0x1008FF13), spawn "amixer -q sset Master 2%+"),

      -- 0x1008FF12: <XF86XK_AudioMute>
      ((0                          , 0x1008FF12), spawn "amixer set Master toggle"),

      -- 0x1008FF14: <XF86XK_AudioPlay>
      ((0                          , 0x1008FF14), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) play-pause"),
      ((mod1Mask                   , 0x1008FF14), spawn "playerctl        --player=$(cat ~/.config/user/player/player) play-pause"),

      -- 0x1008FF16: <XF86XK_AudioPrev>
      ((0                          , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) previous"),
      ((mod1Mask                   , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/player) previous"),
      ((controlMask                , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) position 15-"),
      ((controlMask .|. mod1Mask   , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/player) position 15-"),
      ((shiftMask                  , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) position 5-"),
      ((shiftMask .|. mod1Mask     , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/player) position 5-"),

      -- 0x1008FF17: <XF86XK_AudioNext>
      ((0                          , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) next"),
      ((mod1Mask                   , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/player) next"),
      ((controlMask                , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) position 15+"),
      ((controlMask .|. mod1Mask   , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/player) position 15+"),
      ((shiftMask                  , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) position 5+"),
      ((shiftMask .|. mod1Mask     , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/player) position 5+"),

      -- <Print>: <Print>
      -- To Clipboard
      ((0                          , xK_Print), spawn "scrot '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"),    -- fullscreen screenshot
      ((controlMask                , xK_Print), spawn "scrot -u '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"), -- focused window
      ((shiftMask                  , xK_Print), spawn "scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"), -- manual select
      -- To File
      ((mod1Mask                   , xK_Print), spawn "scrot"),    -- fullscreen screenshot
      ((controlMask .|. mod1Mask   , xK_Print), spawn "scrot -u"), -- focused window
      ((shiftMask .|. mod1Mask     , xK_Print), spawn "scrot -s") -- manual select
    ]
