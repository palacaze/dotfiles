import XMonad
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowArranger
import XMonad.Layout.WindowNavigation

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad
import XMonad.Util.Loggers
import XMonad.Util.WorkspaceCompare

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.MouseResize
import XMonad.Actions.GridSelect
import qualified XMonad.Actions.Search as S
import qualified XMonad.StackSet as W
import Data.List
import System.IO
import System.Exit


myTerminal = "urxvtc"

myFocusFollowsMouse = True

myBorderWidth = 1

myDZenFont = "DejaVu Sans-10"
myDZenMonoFont = "DejaVu Sans Mono-10"
myXMonadFont = "xft:DejaVu Sans Mono:pixelsize=15:autohint=true"

myWhiteColor  = "#E7E8E9"
myDarkColor   = "#393939"
myGreyColor   = "#666666"
myGreenColor  = "#8CC100"
myOrangeColor = "#F79321"
myRedColor    = "#E7212A"

myNormalBorderColor  = myDarkColor
myFocusedBorderColor = myOrangeColor

myIconsDir = "/home/palatin/.icons/xmonad/"

myModMask = mod4Mask

myXPConfig = defaultXPConfig
    { font        = myXMonadFont
    , fgColor     = myGreenColor
    , bgColor     = myDarkColor
    , fgHLight    = myOrangeColor
    , bgHLight    = myDarkColor
    , borderColor = myDarkColor
    , position    = Top
    , height      = 18
    , historySize = 512
    }

myDZenProg = "dzen2" ++
             " -bg '" ++ myDarkColor  ++ "'" ++
             " -fg '" ++ myWhiteColor ++ "'" ++
             " -fn '" ++ myDZenFont   ++ "'" ++
             " -sa c -y 0 -h 18 -ta l -e '' "

myDZenStatusBar = myDZenProg ++ "-w 1280 -x 0"

myDZenCalBar = "dzen-cal -W 1550 -w 270 -r 0 -h 18" ++
               " -bg '" ++ myDarkColor    ++ "'" ++
               " -fg '" ++ myWhiteColor   ++ "'" ++
               " -fn '" ++ myDZenMonoFont ++ "'" ++
               " -hl '" ++ myGreenColor   ++ "'"


-- azerty keyboard keys mapped to workspace switching
azertyWS = ["0x26","0xe9","0x22","0x27","0x28","0x2d","0xe8","0x5f","0xe7","0xe0"]


myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]

myLayout = windowNavigation $ mouseResize $ windowArrange $ smartBorders $ avoidStruts $ 
        tiled
    ||| Mirror tiled
    ||| nobordersLayout
    where
        tiled           = ResizableTall 1 (3/100) (1/2) []
        nobordersLayout = noBorders Full


myScratchPads = [ NS "terminal" spawnTerm   findTerm   manageTerm
                , NS "music"    spawnMusic  findMusic  manageMusic
                , NS "octave"   spawnOctave findOctave manageOctave
                , NS "todo"     spawnTodo   findTodo   manageTodo
                ]
    where
        spawnTerm    = myTerminal ++ " -name scratchterm"
        findTerm     = resource =? "scratchterm"
        manageTerm   = customFloating $ W.RationalRect 0.0 0.6 1.0 0.4  -- x y w h
        spawnMusic   = myTerminal ++ " -name ncmpcpp -e ncmpcpp"
        findMusic    = resource =? "ncmpcpp"
        manageMusic  = customFloating $ W.RationalRect 0.1 0.15 0.8 0.7
        spawnOctave  = myTerminal ++ " -name octave -e octave -q"
        findOctave   = resource =?  "octave"
        manageOctave = customFloating $ W.RationalRect 0.2 0.2 0.6 0.6
        spawnTodo    = myTerminal ++ " -name todo -e vim ~/gentoo/notes/TODO.notes"
        findTodo     = resource =?  "todo"
        manageTodo   = customFloating $ W.RationalRect 0.0 0.0 0.5 0.5


myManageHook :: ManageHook
myManageHook =  composeAll 
    [ resource  =? "desktop_window" --> doIgnore
    , resource  =? "Fichier en cours de traitement" --> doIgnore
    , isDialog                      --> doCenterFloat
    , isFullscreen                  --> doFullFloat
    , title     =? "Downloads"      --> doCenterFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "gnuplot_qt"     --> doFloat
    , className =? "gnuplot"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "xfce4-notifyd"  --> doIgnore
    , className =? "Firefox"        --> doShift " 1 "
    , className =? "Thunderbird"    --> doShift " 2 "
    , resource  =? "irssi"          --> doShift " 3 "
    ] <+> namedScratchpadManageHook myScratchPads 


myDZenLogHook dpipe = dzenPP
    { ppOutput          = hPutStrLn dpipe
    , ppSort            = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
    , ppCurrent         = dzenColor myDarkColor  myGreenColor . wrapClickWS
    , ppHidden          = dzenColor myWhiteColor myGreyColor  . wrapClickWS
    , ppUrgent          = dzenColor myDarkColor  myRedColor   . wrapClickWS
    , ppHiddenNoWindows = dzenColor myWhiteColor myDarkColor  . wrapClickWS
    , ppTitle           = dzenColor myGreenColor "" . pad . shorten 120
    , ppLayout          = dzenColor myWhiteColor "" . pad . wrapClickLayout . \x ->
          case x of
              "ResizableTall"        -> wrapIcon "tall.xbm"
              "Mirror ResizableTall" -> wrapIcon "mtall.xbm"
              "Full"                 -> wrapIcon "full.xbm"
              _                      -> pad x
    }
    where
        wrapClickLayout lay = "^ca(1,xdotool key super+space)" ++ lay ++ "^ca()"
        wrapIcon icon       = "^i(" ++ myIconsDir ++ icon ++ ")"
        wrapClickWS str     = "^ca(1,xdotool key super+" ++ wskey ++ ")" ++ pad str ++ "^ca()"
            where
                wsIndex Nothing  = 0
                wsIndex (Just n) = n
                wskey = azertyWS !! wsIndex (elemIndex str myWorkspaces)


myGSConfig = (buildDefaultGSConfig myColorizer)
    { gs_cellheight  = 30
    , gs_cellwidth   = 200
    , gs_cellpadding = 10
    , gs_font        = myXMonadFont
    }
    where
        myColorizer s active = if active
                               then return (myGreenColor, myDarkColor)
                               else return (myDarkColor, myWhiteColor)


myGridApps = ["nvidia-settings", "calibre", "deluge", "qtcreator", "inkscape", "gimp", "urxvtd -q -f -o"]


myRestart = "for pid in `pgrep dzen2`; do kill -9 $pid; done && xmonad --recompile && xmonad --restart"


myKeys =
    [ ("M-M1-<KP_Add>",      spawn "transset -a --inc 0.1")
    , ("M-M1-<KP_Subtract>", spawn "transset -a --min 0.1 --dec 0.1")

    , ("M-s",              namedScratchpadAction myScratchPads "terminal")
    , ("M-m",              namedScratchpadAction myScratchPads "music")
    , ("M-o",              namedScratchpadAction myScratchPads "octave")
    , ("<XF86Calculator>", namedScratchpadAction myScratchPads "octave")
    , ("M-n",              namedScratchpadAction myScratchPads "todo")

    , ("M-f",        spawn "thunar")
    , ("C-M1-x",     spawn (myTerminal ++ " -e vim ~/.xmonad/xmonad.hs"))
    , ("M-i",        raiseMaybe (runInTerm "-name irssi" "irssi") (resource =? "irssi"))
    , ("M-w",        runOrRaise "firefox" (className =? "Firefox"))
    , ("M-e",        runOrRaise "thunderbird" (className =? "Thunderbird"))
    , ("M-r",        shellPrompt myXPConfig)
    , ("M1-<F2>",    shellPrompt myXPConfig)
    , ("C-M1-l",     spawn "xscreensaver-command -lock")
    , ("M1-<Print>", unsafeSpawn "sleep 0.2; scrot -s -e 'mv $f ~/screenshots/'")
    , ("<Print>",    unsafeSpawn "scrot -e 'mv $f ~/screenshots/'")
    , ("M-v",        spawnSelected myGSConfig myGridApps)

    , ("<XF86AudioLowerVolume>", unsafeSpawn "amixer set Master 3%-")
    , ("<XF86AudioRaiseVolume>", unsafeSpawn "amixer set Master 3%+")
    , ("<XF86AudioMute>",        unsafeSpawn "amixer set Master toggle")
    , ("<XF86Launch8>",          safeSpawn   "ncmpcpp" ["prev"])
    , ("<XF86Launch9>",          safeSpawn   "ncmpcpp" ["next"])
    , ("<XF86AudioPlay>",        safeSpawn   "ncmpcpp" ["toggle"])
    ] ++

    [ ("M-a " ++ k, S.selectSearch f) | (k,f) <- searchList
    ] ++

    [ ("M-S-<Right>",  moveTo Next (WSIs notNSP))
    , ("M-S-<Left>",   moveTo Prev (WSIs notNSP))
    , ("M-S-<Up>",     shiftTo Next (WSIs notNSP))
    , ("M-S-<Down>",   shiftTo Prev (WSIs notNSP))

    , ("C-M-<Right>",  sendMessage Expand)
    , ("C-M-<Left>",   sendMessage Shrink)
    , ("C-M-<Down>",   sendMessage MirrorShrink)
    , ("C-M-<Up>",     sendMessage MirrorExpand)

    , ("M-<Right>",    sendMessage $ Go R)
    , ("M-<Left>",     sendMessage $ Go L)
    , ("M-<Down>",     sendMessage $ Go D)
    , ("M-<Up>",       sendMessage $ Go U)
    , ("M1-M-<Right>", sendMessage $ Swap R)
    , ("M1-M-<Left>",  sendMessage $ Swap L)
    , ("M1-M-<Down>",  sendMessage $ Swap D)
    , ("M1-M-<Up>",    sendMessage $ Swap U)

    , ("M-<KP_Add>",      sendMessage (IncMasterN 1))
    , ("M-<KP_Subtract>", sendMessage (IncMasterN (-1)))
    , ("M-<Tab>",         myToggle)
    , ("M1-<Tab>",        windows W.focusDown)
    , ("M1-<F4>",         kill)
    , ("M-q",             spawn myRestart)
    ]
    where
        -- | avoid scratchpad "NSP" workspace when toggling, moving or shifting ws
        notNSP = (return $ ("NSP" /=) . W.tag) :: X (WindowSpace -> Bool)
        myToggle = windows $ W.view =<< W.tag . head . filter
                   ((\x -> x /= "NSP") . W.tag) . W.hidden

gentooBugsEngine = S.searchEngine "Gentoo Bugzilla" "https://bugs.gentoo.org/buglist.cgi?quicksearch=ALL+"

searchList :: [(String, S.SearchEngine)]
searchList =  [ ("g", S.google)
              , ("w", S.wikipedia)
              , ("b", gentooBugsEngine)
              ]

myConf = withUrgencyHook NoUrgencyHook $ ewmh azertyConfig
    { modMask            = myModMask
    , terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , manageHook         = manageDocks <+> myManageHook
    , layoutHook         = myLayout
    } `additionalKeysP` myKeys


main = do
    dzpipe  <- spawnPipe myDZenStatusBar
    dzcal   <- spawnPipe myDZenCalBar
    xmonad myConf
        { logHook     = dynamicLogWithPP $ myDZenLogHook dzpipe
        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
        }

