module Css.Autoprefixer where

import Dict exposing (Dict)
import Css.Autoprefixer.Data as Data
import Css.Autoprefixer.Stats exposing (BrowserVersion(..), parseStats)


requirements : Dict String (List BrowserVersion)
requirements =
  Dict.fromList
    [ ("box-shadow", parseStats Data.boxShadow)
    , ("border-radius", parseStats Data.borderRadius)
    , ("")
    ]
