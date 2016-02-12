module Css.Autoprefixer.Stats
  ( BrowserVersion(..)
  , parseStats
  ) where

import Result
import Regex
import Json.Decode as Decode exposing (string, keyValuePairs, at)


type BrowserVersion =
  BrowserVersion String String


parseStats : String -> List BrowserVersion
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
      |> List.map (\(browser, version, _) -> BrowserVersion browser version)
