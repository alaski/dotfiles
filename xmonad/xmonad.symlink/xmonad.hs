import qualified Data.Map as M
import System.IO
import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Util.EZConfig
import XMonad.Util.Run


myTerminal = "terminator"

-- Define amount and names of workspaces
myWorkspaces = ["1:main","2:web","3","4:pandora","5:float","6","7","8","9"]

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Xfce4-appfinder"--> doFloat
    , className =? "Xfrun4"         --> doFloat
    , className =? "Google-chrome"  --> doShift "3"
    , resource  =? "www.pandora.com"  --> doShift "4:pandora"
    , title     =? "Convergence"  --> doShift "5:float"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ xfceConfig 
    { terminal   = myTerminal
    , modMask    = mod4Mask
    , workspaces = myWorkspaces
    , manageHook = manageDocks <+> myManageHook <+> manageHook xfceConfig
    , layoutHook = avoidStruts $ onWorkspace "5:float" simplestFloat $ layoutHook xfceConfig
    , logHook = dynamicLogWithPP $ xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 50
        , ppLayout = const "" -- to disable the layout info on xmobar
        }
    }
