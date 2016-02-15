module Css.Autoprefix.Transform
  ( Transform
  , transform
  , execute
  ) where

import String
import Css.Preprocess exposing (Property)
import Css.Autoprefix.BrowserRange exposing (BrowserRange)
import Css.Autoprefix.Utils as Utils


type alias Operation =
  Property -> List Property


type alias Transform =
  { ranges : List BrowserRange
  , operations : List Operation
  }


transform : List BrowserRange -> List Operation -> Transform
transform =
  Transform


execute : Property -> List Operation -> List Property
execute property operations =
  List.foldl
    (\nextOp result -> List.concatMap nextOp result)
    ([property])
    (operations)


mapKey : (String -> String) -> Property -> Property
mapKey mapper prop =
  { prop | key = mapper prop.key }


mapValue : (String -> String) -> Property -> Property
mapValue mapper prop =
  { prop | value = mapper prop.value }


wrapList : a -> List a
wrapList item =
  [item]




alignContent2012 : Operation
alignContent2012 property =
  property
    |> mapKey (Utils.mapBaseName (always "flex-line-pack"))
    |> mapValue
      (\value ->
        case value of
          "flex-end" -> "end"
          "flex-start" -> "start"
          "space-between" -> "justify"
          "space-around" -> "distribute"
          _ -> value )
    |> wrapList


alignItems2009 : Operation
alignItems2009 =
  mapKey (Utils.mapBaseName (always "box-align"))
    >> mapValue
      (\value ->
        case value of
          "flex-end" -> "end"
          "flex-start" -> "start"
          _ -> value )
    >> wrapList


alignItems2012 : Operation
alignItems2012 =
  mapKey (Utils.mapBaseName (always "flex-align"))
    >> mapValue
      (\value ->
        case value of
          "flex-end" -> "end"
          "flex-start" -> "start"
          _ -> value )
    >> wrapList


alignSelf2012 : Operation
alignSelf2012 =
  mapKey (Utils.mapBaseName (always "flex-item-align"))
    >> mapValue
      (\value ->
        case value of
          "flex-end" -> "end"
          "flex-start" -> "start"
          _ -> value )
    >> wrapList


backgroundSize : Operation
backgroundSize property =
  let
    value =
      property.value

    needsDuplication =
      value /= "contain" && value /= "cover" && not (String.contains " " value)
  in
    if needsDuplication then
      { property | value = value ++ " " ++ value }
        |> wrapList
    else
      wrapList property


blockLogical : Operation
blockLogical =
  mapKey (Utils.stringReplace "-block-start" "-before")
  >> mapKey (Utils.stringReplace "-block-end" "-after")
  >> wrapList


borderImage : Operation
borderImage =
  mapValue (Utils.stringReplace "fill" "")
  >> wrapList


borderRadius : Operation
borderRadius property =
  let
    split =
      String.split "-" property.key

    vertical =
      split |> List.drop 1 |> List.head |> Maybe.withDefault ""

    horizontal =
      split |> List.drop 2 |> List.head |> Maybe.withDefault ""

    result =
      if vertical /= "top" || vertical /= "bottom" then
        property.key
      else if horizontal /= "left" || horizontal /= "right" then
        property.key
      else
        "border-radius-" ++ vertical ++ horizontal
  in
    { property | key = result } |> wrapList
