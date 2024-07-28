import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Xmonad Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D (..), WSType (..), moveTo, nextScreen, prevScreen, shiftTo)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotAllDown, rotSlavesDown)
import XMonad.Actions.UpdateFocus
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (killAll, sinkAll)
import qualified XMonad.Actions.Search as S

-- Xmonad Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WorkspaceHistory

-- Xmonad Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
-- Xmonad Layouts Modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile(MirrorResize (MirrorShrink, MirrorExpand) )
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Xmonad Utils
import XMonad.Util.Dmenu
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- Data
import Data.Char (isSpace, toUpper)
import qualified Data.Map as M
import Data.Maybe (fromJust, isJust)
import Data.Monoid
import Data.Tree


-----------------------------------------------------------------------
----------------------- Global Config Variables -----------------------
-----------------------------------------------------------------------
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myTerminal = "wezterm start --class wezterm"
myBrowser = "firefox "

myModMask = mod4Mask

myFocusFollowsMouse = False
myClickJustFocuses = False

-- Workspaces
myWorkspaces = ["\xf120","\xf269","\xf1bc","Alt-1","\xf130","\xf7b3","\xeac4","\xf1ad","Alt-2"]

-- Window Borders
myBorderWidth = 3
myNormColor = "#DD9944"
myFocusColor = "#DD5555"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-----------------------------------------------------------------------
-------- Key bindings. Add, modify or remove key bindings here --------
-----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
    --- Use Shortcuts ---
    ((modm .|. shiftMask , xK_Return), spawn $ XMonad.terminal conf),
    ((modm               , xK_p     ), spawn "nice -n 1 rofi -show drun"),
    ((modm .|. shiftMask , xK_p     ), spawn "nice -n 1 rofi -show run"),
    ((modm               , xK_f     ), spawn "nice -n 1 rofi -show filebrowser"),
    ((modm               , xK_Tab   ), spawn "rofi -show window"),
    ((modm .|. mod1Mask  , xK_period), spawn "rofimoji"),
    ((modm               , xK_minus ), spawn "dunstctl context"),
    ((modm .|. mod1Mask  , xK_comma ), spawn "xdotool type $(unipicker --command 'rofi -dmenu')"),
    ((modm .|. shiftMask , xK_c     ), kill),
    ((modm               , xK_space ), sendMessage NextLayout),
    ((modm .|. shiftMask , xK_space ), setLayout $ XMonad.layoutHook conf),
    ((modm               , xK_n     ), refresh),

    --- Focus Windows ---
    ((modm               , xK_F1    ), focusUnderPointer), -- mouse macro
    ((mod1Mask           , xK_Tab   ), windows W.focusDown),
    ((modm               , xK_j     ), windows W.focusDown),
    ((modm               , xK_k     ), windows W.focusUp  ),
    ((modm               , xK_m     ), windows W.focusMaster  ),
    ((modm               , xK_Return), windows W.swapMaster),

    -- Swap Focused Windows --
    ((modm .|. shiftMask , xK_j     ), windows W.swapDown  ),
    ((modm .|. shiftMask , xK_k     ), windows W.swapUp    ),

    --- Windows Sizes and Positions ---
    ((modm               , xK_h     ), sendMessage Shrink),
    ((modm .|. shiftMask , xK_h     ), sendMessage MirrorShrink),
    ((modm               , xK_l     ), sendMessage Expand),
    ((modm .|. shiftMask , xK_l     ), sendMessage MirrorExpand),
    ((modm               , xK_t     ), withFocused $ windows . W.sink),

    -- Number of Windows in Master Area --
    ((modm               , xK_comma ), sendMessage (IncMasterN 1)),
    ((modm               , xK_period), sendMessage (IncMasterN (-1))),

    -- Picom Stuff --
    ((modm               , xK_a     ), spawn "picom-trans -ct"), -- toggle transparency

    --- Direct XMonad Stuff ---
    ((modm .|. shiftMask , xK_q     ), io exitSuccess),
    ((modm               , xK_q     ), spawn "xmonad --recompile && xmonad --restart; killall xmobar; xmobar; notify-send \"xmonad and xmobar restarted\""),

    --- Xrandr Brightness ---
    ((modm .|. mod1Mask                  , xK_space       ), spawn "bright s+100"),
    ((modm .|. mod1Mask                  , xK_KP_Add      ), spawn "bright +5"),
    ((modm .|. mod1Mask                  , xK_KP_Subtract ), spawn "bright -5"),
    ((modm .|. mod1Mask .|. shiftMask    , xK_KP_Add      ), spawn "bright +2"),
    ((modm .|. mod1Mask .|. shiftMask    , xK_KP_Subtract ), spawn "bright -2"),
    ((modm .|. mod1Mask .|. controlMask  , xK_KP_Add      ), spawn "bright +15"),
    ((modm .|. mod1Mask .|. controlMask  , xK_KP_Subtract ), spawn "bright -15")
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

-- myLayout = spacingWithEdge 10 (gaps [(U, 18), (R, 15), (D, 18), (L, 15)] (smartBorders tiled)) |||
--            spacingWithEdge 10 (gaps [(U, 18), (R, 15), (D, 18), (L, 15)] (Mirror (smartBorders tiled))) |||
--            fullscreenFull (gaps [(U, 20)] (noBorders Full))

myLayout = lessBorders OnlyScreenFloat $
  spacingWithEdge 10 (gaps [(U, 18), (R, 15), (D, 18), (L, 15)] (tiled ||| Mirror tiled)) ||| fullscreenFull (noBorders Full)
    where
      tiled   = ResizableTall nmaster delta ratio []
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
myManageHook = do
  XMonad.Layout.Fullscreen.fullscreenManageHook
  composeAll
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
myEventHook = XMonad.Layout.Fullscreen.fullscreenEventHook

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
myLogHook = dynamicLogXinerama

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
myStartupHook = do
    setWMName "LG3D"
    setDefaultCursor xC_left_ptr

    spawn "xscreensaver -no-splash &"
    spawn "unclutter -idle 10 -root &"
    spawn "xmobar &"
    spawn "dunst"
    spawn "picom --daemon --experimental-backends &"

    spawn "/home/javalsai/.screenlayout/test.sh && nitrogen --restore" -- set the functionality in `xorg.conf` and remove after-setup-configurations that just take time (or move to WL)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad $ fullscreenSupport $ ewmhFullscreen . ewmh $ defaults
main = xmonad . fullscreenSupport . ewmhFullscreen . ewmh =<< xmobar defaults

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
        normalBorderColor  = myNormColor,
        focusedBorderColor = myFocusColor,

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
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "dunstctl is-paused > /tmp/dnst; dunstctl set-paused true; xscreensaver-command -lock; cat /tmp/dnst | xargs dunstctl set-paused; rm /tmp/dnst;"),

      -- https://github.com/freedesktop/xorg-x11proto/blob/master/XF86keysym.h
      -- 0x1008FF11: <XF86XK_AudioLowerVolume>
      ((0                          , 0x1008FF11), spawn "volume -5"),
      ((controlMask                , 0x1008FF11), spawn "volume -10"),
      ((shiftMask                  , 0x1008FF11), spawn "volume -2"),

      -- 0x1008FF13: <XF86XK_AudioRaiseVolume>
      ((0                          , 0x1008FF13), spawn "volume 5"),
      ((controlMask                , 0x1008FF13), spawn "volume 10"),
      ((shiftMask                  , 0x1008FF13), spawn "volume 2"),

      -- 0x1008FF12: <XF86XK_AudioMute>
      ((0                          , 0x1008FF12), spawn "amixer set Master toggle"),

      -- 0x1008FF14: <XF86XK_AudioPlay>
      ((0                          , 0x1008FF14), spawn "playerctl        --player=$(cat ~/.config/user/player/player) play-pause"),
      ((mod1Mask                   , 0x1008FF14), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) play-pause"),
      ((controlMask                , 0x1008FF14), spawn "playerctl        --all-players                                play-pause"),
      ((controlMask .|. shiftMask  , 0x1008FF14), spawn "playerctl        --all-players                                play"),
      ((controlMask .|. mod1Mask   , 0x1008FF14), spawn "playerctl        --all-players                                pause"),

      -- 0x1008FF16: <XF86XK_AudioPrev>
      ((0                          , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/ignore) previous"),
      ((mod1Mask                   , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/player) previous"),
      ((controlMask                , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/ignore) position 15-"),
      ((controlMask .|. mod1Mask   , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/player) position 15-"),
      ((shiftMask                  , 0x1008FF16), spawn "playerctl        --player=$(cat ~/.config/user/player/ignore) position 5-"),
      ((shiftMask .|. mod1Mask     , 0x1008FF16), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/player) position 5-"),

      -- 0x1008FF17: <XF86XK_AudioNext>
      ((0                          , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/player) next"),
      ((mod1Mask                   , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/ignore) next"),
      ((controlMask                , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/ignore) position 15+"),
      ((controlMask .|. mod1Mask   , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/player) position 15+"),
      ((shiftMask                  , 0x1008FF17), spawn "playerctl        --player=$(cat ~/.config/user/player/ignore) position 5+"),
      ((shiftMask .|. mod1Mask     , 0x1008FF17), spawn "playerctl --ignore-player=$(cat ~/.config/user/player/player) position 5+"),

      -- <Print>: <Print>
      -- To Clipboard
      ((0                          , xK_Print), spawn "scrot    '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"),    -- fullscreen screenshot
      ((controlMask                , xK_Print), spawn "scrot -u '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"), -- focused window
      ((shiftMask                  , xK_Print), spawn "scrot -s --freeze '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"), -- manual select
      -- To File
      ((mod1Mask                   , xK_Print), spawn "scrot"),    -- fullscreen screenshot
      ((controlMask .|. mod1Mask   , xK_Print), spawn "scrot -u"), -- focused window
      ((shiftMask .|. mod1Mask     , xK_Print), spawn "scrot -s --freeze"),  -- manual select

      -- 0x1008FF2F: <XF86XK_Sleep>
      ((0                          , 0x1008FF2F), spawn "systemctl hibernate")
    ]
