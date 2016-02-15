module Css.Autoprefix.Transform
  ( Transform
  , transform
  , execute
  ) where

import Css.Preprocess exposing (Property)
import Css.Autoprefix.BrowserRange exposing (BrowserRange)



type alias Transform =
  { ranges : List BrowserRange
  , operations : List (Property -> List Property)
  }


transform : List BrowserRange -> List (Property -> List Property) -> Transform
transform =
  Transform


execute : Property -> List (Property -> List Property) -> List Property
execute property operations =
  List.foldl
    (\nextOp result -> List.concatMap nextOp result)
    ([property])
    (operations)
