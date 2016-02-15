module Css.Autoprefix.BrowserRange
  ( Vendor(..)
  , Version
  , BrowserRange
  , version
  , range
  , overlaps
  ) where

import String

type Vendor
  = InternetExplorer
  | InternetExplorerMobile
  | Edge
  | Firefox
  | Chrome
  | Safari
  | IosSafari
  | Android
  | AndroidChrome
  | AndroidFirefox
  | AndroidUc
  | Opera
  | OperaMini
  | OperaMobile
  | BlackBerry


type alias Version =
  { major : Int
  , minor : Int
  , patch : Int
  }


type alias BrowserRange =
  { vendor : Vendor
  , minVersion : Version
  , maxVersion : Version
  }


version : Int -> Int -> Int -> Version
version =
  Version


range : Vendor -> Version -> Version -> BrowserRange
range =
  BrowserRange


parseVersion : String -> Version
parseVersion value =
  let
    parseComponent maybeValue =
      maybeValue
      |> (flip Maybe.andThen) (String.toInt >> Result.toMaybe)
      |> Maybe.withDefault 0

    split =
      String.split "." value

    first =
      split |> List.head |> parseComponent

    second =
      split |> List.drop 1 |> List.head |> parseComponent

    third =
      split |> List.drop 2 |> List.head |> parseComponent
  in
    Version first second third

compareVersion : Version -> Version -> Order
compareVersion left right =
  let
    leftSequence =
      [left.major, left.minor, left.patch]

    rightSequence =
      [right.major, right.minor, right.patch]

    actualCompare (leftComp, rightComp) current =
      if leftComp /= rightComp then
        compare leftComp rightComp
      else
        current
  in
    rightSequence
      |> List.map2 (,) leftSequence
      |> List.foldr actualCompare EQ


versionLtOrEq : Version -> Version -> Bool
versionLtOrEq left right =
  (compareVersion left right) /= GT


versionGtOrEq : Version -> Version -> Bool
versionGtOrEq left right =
  (compareVersion left right) /= LT


overlaps : BrowserRange -> BrowserRange -> Bool
overlaps left right =
  if left.vendor /= right.vendor then
    False
  else
    (versionLtOrEq left.maxVersion right.maxVersion)
    |> (||) (versionGtOrEq left.minVersion right.minVersion)
