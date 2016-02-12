module Css.Autoprefixer.Stats
  ( BrowserSupport
  , Browser(..)
  , Version(..)
  , SupportLevel(..)
  , parseStats
  ) where

import Result
import Maybe
import String
import Regex
import Json.Decode as Decode exposing (string, keyValuePairs, at)


type Browser
  = InternetExplorer
  | Edge
  | Firefox
  | Chrome
  | Safari
  | Opera
  | IosSafari
  | OperaMini
  | Android
  | BlackBerry
  | OperaMobile
  | AndroidChrome
  | AndroidFirefox
  | InternetExplorerMobile
  | UcForAndroid
  | Unknown


parseBrowser : String -> Browser
parseBrowser value =
  case value of
    "ie" -> InternetExplorer
    "edge" -> Edge
    "firefox" -> Firefox
    "chrome" -> Chrome
    "safari" -> Safari
    "opera" -> Opera
    "ios_saf" -> IosSafari
    "op_mini" -> OperaMini
    "android" -> Android
    "bb" -> BlackBerry
    "op_mob" -> OperaMobile
    "and_chr" -> AndroidChrome
    "and_ff" -> AndroidFirefox
    "ie_mob" -> InternetExplorerMobile
    "and_uc" -> UcForAndroid
    _ -> Unknown


type Version
  = SingleVersion String
  | RangeVersion String String


parseVersion : String -> Version
parseVersion value =
  if String.contains "-" value then
    let
      split =
        String.split "-" value

      first =
        split |> List.head |> Maybe.withDefault ""

      second =
        split |> List.drop 1 |> List.head |> Maybe.withDefault ""
    in
      RangeVersion first second
  else
    SingleVersion value


type SupportLevel
  = Partial
  | Full


parseSupportLevel : String -> SupportLevel
parseSupportLevel value =
  if String.contains "y x" value then
    Full
  else
    Partial


type alias BrowserSupport =
  (Browser, Version, SupportLevel)


parseBrowserSupport : (String, String, String) -> BrowserSupport
parseBrowserSupport (browser, version, level) =
  ( parseBrowser browser
  , parseVersion version
  , parseSupportLevel level
  )


parseStats : String -> List BrowserSupport
parseStats json =
  let
    mapVersionSupportWithBrowser browser (version, support) =
      (browser, version, support)

    mapBrowserWithVersionSupportList (browser, versionSupportList) =
      versionSupportList
        |> List.map (mapVersionSupportWithBrowser browser)

    matches =
      Regex.contains (Regex.regex "\\sx($|\\s)")

    third (_, _, c) =
      c
  in
    json
      |> Decode.decodeString (keyValuePairs (keyValuePairs string))
      |> Result.withDefault []
      |> List.concatMap mapBrowserWithVersionSupportList
      |> List.filter (third >> matches)
      |> List.map parseBrowserSupport
