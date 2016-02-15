module Tests where

import String
import ElmTest exposing (..)
import Css exposing (..)
import Css.Elements as El
import Css.Autoprefix exposing (autoprefix)
import Css.Autoprefix.Presets exposing (everything)


all : Test
all =
  suite "A Test Suite"
    [ test "first test" firstTest ]


firstTest : Assertion
firstTest =
  let
    actual =
      prettyPrint <|
        (Css.stylesheet << (autoprefix everything))
          [ El.div [ (property "align-content" "flex-end") ]
          ]

    expected =
      "div {\n    -ms-flex-line-pack: end;\n    align-content: flex-end;\n}"
  in
    assertEqual actual expected


prettyPrint : Css.Stylesheet -> String
prettyPrint sheet =
  let
    { warnings, css } =
      Css.compile sheet
  in
    if List.isEmpty warnings then
      css
    else
      "Invalid Stylesheet:\n" ++ (String.join "\n" warnings)
