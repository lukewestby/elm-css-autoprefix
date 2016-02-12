module Css.Autoprefixer where

import Dict exposing (Dict)
import Css.Autoprefixer.Data as Data
import Css.Autoprefixer.Stats as Stats

type alias Requirement =
  { browsers : List Stats.BrowserSupport
  , mistakes : List String
  , props: List String
  , selector : Bool
  }


requirement : Requirement
requirement =
  { browsers = []
  , mistakes = []
  , props = []
  , selector = False
  }


withBrowsers : List Stats.BrowserSupport -> Requirement -> Requirement
withBrowsers browsers requirement =
  { requirement | browsers = (List.append requirement.browsers browsers) }


withMistakes : List String -> Requirement -> Requirement
withMistakes mistakes requirement =
  { requirement | mistakes = List.append requirement.mistakes mistakes }


withProps : List String -> Requirement -> Requirement
withProps props requirement =
  { requirement | props = List.append requirement.props props }


withSelector : Requirement -> Requirement
withSelector requirement =
  { requirement | selector = True }


addRequirements : List String -> Requirement -> Dict String Requirement -> Dict String Requirement
addRequirements names requirement requirementsMap =
  names
    |> List.map (\name -> (name, requirement))
    |> Dict.fromList
    |> Dict.union requirementsMap

requirements : Dict String Requirement
requirements =
  let
    addBorderRadius =
      addRequirements
      [ "border-radius"
      , "border-top-left-radius"
      , "border-top-right-radius"
      , "border-bottom-right-radius"
      , "border-bottom-left-radius"
      ]
      requirement
        |> withBrowsers Data.borderRadius
        |> withMistakes ["-khtml-", "-ms-" , "-o-"] )

    addBoxShadow =
      addRequirements
      [ "box-shadow" ]
      requirement
        |> withBrowsers Data.boxShadow
        |> withMistakes ["-khtml-"]
  in
    Dict.empty
      |> addBorderRadius
      |> addBoxShadow
