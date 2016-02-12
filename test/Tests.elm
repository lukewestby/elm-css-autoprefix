module Tests where

import ElmTest exposing (..)
import Css.Autoprefixer exposing (filteredBoxShadowStats)


all : Test
all =
  suite "A Test Suite"
    [ test "filteredTest" filteredTest
    ]

filteredTest =
  let
    expected =
      [ ("firefox", "3.5", "y x")
      , ("firefox", "3.6", "y x")
      , ("chrome", "4", "y x")
      , ("chrome", "5", "y x")
      , ("chrome", "6", "y x")
      , ("chrome", "7", "y x")
      , ("chrome", "8", "y x")
      , ("chrome", "9", "y x")
      , ("safari", "3.1", "a x #1")
      , ("safari", "3.2", "a x #1")
      , ("safari", "4", "a x #1")
      , ("safari", "5", "y x")
      , ("ios_saf", "3.2", "a x #1")
      , ("ios_saf", "4.0-4.1", "y x")
      , ("ios_saf", "4.2-4.3", "y x")
      , ("android", "2.1", "a x #1")
      , ("android", "2.2", "a x #1")
      , ("android", "2.3", "a x #1")
      , ("android", "3", "a x #1")
      , ("bb", "7", "y x")
      ]
  in
    assertionList (List.reverse expected) filteredBoxShadowStats
