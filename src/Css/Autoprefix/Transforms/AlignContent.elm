module Css.Autoprefix.Transforms.AlignContent where

import Css.Autoprefix.Transform as Transform exposing (..)
import Css.Autoprefix.BrowserRange as BrowserRange exposing (..)
import Css.Autoprefix.Utils as Utils


backport2012 : Transform
backport2012 =
  let
    execute prop =
      [ { prop
        | key = (Utils.mapBaseName (always "flex-line-pack") prop.key)
        , value =
            case prop.value of
              "flex-end" -> "end"
              "flex-start" -> "start"
              "space-between" -> "justify"
              "space-around" -> "distribute"
              _ -> prop.value
        }
      ]

    prefixMs prop =
      [{ prop | key = "-ms-" ++ prop.key }]
  in
    transform
      [ range InternetExplorer (version 10 0 0) (version 10 0 0)
      , range InternetExplorerMobile (version 10 0 0) (version 10 0 0)
      ]
      [execute, prefixMs]
