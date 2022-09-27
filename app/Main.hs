module Main where

import Xmobar
    ( Config(..), Date(Date)
    , Monitors(Wireless, Memory, Uptime, Cpu, Network, DiskU), Runnable(Run)
    , StdinReader(StdinReader), XPosition(Top), defaultConfig, xmobar )


main :: IO ()
main =
    xmobar config


config :: Config
config =
    defaultConfig
    { font     = "xft:Noto Sans CJK TC:pixelsize=24:Medium"
    , bgColor  = "#262626"
    , alpha    = 216
    , fgColor  = "#777777"
    , position = Top
    , commands = [ Run $ Date "星期%u %Y年%m月%d日 %H:%M" "date" 600
                 , Run $ Wireless "wlp76s0" [ "-x", "", "-t", "<essid>" ] 100
                 , Run StdinReader
                 , Run $ Network "enp78s0" [ "-t", "↓<rx>KB ↑<tx>KB" ] 10
                 , Run $ DiskU [ ("/", "/: <used>/<size>") ] [] 60
                 , Run $ Cpu ["-L","5","-H","50","--normal","green","--high","red", "-t", "CPU: <total>%"] 10
                 , Run $ Uptime ["-t", "Up: <days>d <hours>h <minutes>m"] 36000
                 , Run $ Memory [ "-t", "Mem: <usedratio>%" ] 10
                 ]
    , sepChar  = "%"
    , alignSep = "}{"
    , template = " %StdinReader% } <fc=#505050>%date%</fc> { %enp78s0%   %disku%   %cpu%   %uptime%   %memory% "
    }
