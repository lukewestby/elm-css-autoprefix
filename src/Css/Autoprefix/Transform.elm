module Css.Autoprefix.Transform
  ( TransformOperation(..)
  , Transform
  , singleTransform
  , multiTransform
  , transform
  , execute
  ) where

import Css.Preprocess exposing (Property)
import Css.Autoprefix.BrowserRange exposing (BrowserRange)


type TransformOperation
  = SingleTransform (Property -> Property)
  | MultiTransform (Property -> List Property)


type alias Transform =
  { ranges : List BrowserRange
  , operation : TransformOperation
  }


execute : Property -> TransformOperation -> List Property
execute property operation =
  case operation of
    SingleTransform fn ->
      [fn property]
    MultiTransform fn ->
      fn property


singleTransform : (Property -> Property) -> TransformOperation
singleTransform =
  SingleTransform


multiTransform : (Property -> List Property) -> TransformOperation
multiTransform =
  MultiTransform


transform : List BrowserRange -> TransformOperation -> Transform
transform =
  Transform
