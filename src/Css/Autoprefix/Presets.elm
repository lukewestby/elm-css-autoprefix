module Css.Autoprefix.Presets where

import Css.Autoprefix.BrowserRange exposing (..)

everything : List BrowserRange
everything =
  [ range
      (InternetExplorer)
      (version 6 0 0)
      (version 11 0 0)
  , range
      (InternetExplorerMobile)
      (version 10 0 0)
      (version 10 0 0)
  , range
      (Edge)
      (version 12 0 0)
      (version 14 0 0)
  , range
      (Firefox)
      (version 2 0 0)
      (version 47 0 0)
  , range
      (Chrome)
      (version 4 0 0)
      (version 51 0 0)
  , range
      (Safari)
      (version 3 1 0)
      (version 9 1 0)
  , range
      (Opera)
      (version 10 1 0)
      (version 36 0 0)
  , range
      (IosSafari)
      (version 3 2 0)
      (version 9 3 0)
  , range
      (OperaMini)
      (version 8 0 0)
      (version 8 0 0)
  , range
      (Android)
      (version 2 1 0)
      (version 47 0 0)
  , range
      (BlackBerry)
      (version 7 0 0)
      (version 10 0 0)
  , range
      (OperaMobile)
      (version 12 0 0)
      (version 33 0 0)
  , range
      (AndroidChrome)
      (version 47 0 0)
      (version 47 0 0)
  , range
      (AndroidFirefox)
      (version 44 0 0)
      (version 44 0 0)
  , range
      (AndroidUc)
      (version 9 9 0)
      (version 9 9 0)
  ]
