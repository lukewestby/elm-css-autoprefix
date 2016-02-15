module Css.Autoprefix.Transforms.AlignContent where

import Css.Autoprefix.Transform as Transform exposing (..)
import Css.Autoprefix.BrowserRange as BrowserRange exposing (..)


backport2012IE : Transform
backport2012IE =
  let
    execute prop =
      { prop
      | key = "-ms-flex-line-pack"
      , value =
          case prop.value of
            "flex-end" -> "end"
            "flex-start" -> "start"
            "space-between" -> "justify"
            "space-around" -> "distribute"
            _ -> prop.value
      }
  in
    transform
      [ range InternetExplorer (version 10 0 0) (version 10 0 0)
      , range InternetExplorerMobile (version 10 0 0) (version 10 0 0)
      ]
      (singleTransform execute)
