module Main where

import Xmobar
    ( Config(..), Date(Date), Monitors(Wireless, Memory), Runnable(Run)
    , StdinReader(StdinReader), XPosition(BottomP), defaultConfig, xmobar )

config :: Config
config =
    defaultConfig
    { font     = "xft:Noto Sans CJK TC:pixelsize=24:Medium"
    , bgColor  = "#262626"
    , alpha    = 216
    , fgColor  = "#777777"
    , position = BottomP 0 0
    , commands = [ Run $ Date "星期%u %Y年%m月%d日 %H:%M" "date" 600
                 , Run $ Wireless "wlp76s0" [ "-x", "", "-t", "<essid>" ] 100
                 , Run StdinReader
                 , Run $ Memory [ "-t", "Mem: <usedratio>%" ] 10
                 ]
    , sepChar  = "%"
    , alignSep = "}{"
    , template = " %StdinReader% } <fc=#505050>%date%</fc> { %memory% "
    }

main :: IO ()
main =
    xmobar config
