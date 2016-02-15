module Css.Autoprefix
  ( autoprefix
  ) where

{-| Css.Autoprefix

@docs autoprefix
-}

import Dict exposing (Dict)
import Css.Autoprefix.BrowserRange as BrowserRange exposing (..)
import Css.Autoprefix.Transform as Transform exposing (Transform)
import Css.Autoprefix.Transforms.AlignContent as AlignContent
import Css.Preprocess exposing (..)


keyTransforms : Dict String (List Transform)
keyTransforms =
  Dict.fromList
    [ ("align-content", [AlignContent.backport2012IE]) ]


type alias Config =
  List BrowserRange


{-|
-}
autoprefix : Config -> List Snippet -> List Snippet
autoprefix config snippets =
  List.map (processSnippet config) snippets


processSnippet : Config -> Snippet -> Snippet
processSnippet config (Snippet declarations) =
  declarations
    |> List.map (processDeclaration config)
    |> Snippet


processDeclaration : Config -> SnippetDeclaration -> SnippetDeclaration
processDeclaration config declaration =
  case declaration of
    StyleBlockDeclaration styleBlock ->
      styleBlock
        |> processStyleBlock config
        |> StyleBlockDeclaration

    _ ->
      declaration


processStyleBlock : Config -> StyleBlock -> StyleBlock
processStyleBlock config (StyleBlock selector others mixins) =
  mixins
    |> List.map (processMixin config)
    |> StyleBlock selector others


processMixin : Config -> Mixin -> Mixin
processMixin config mixin =
  case mixin of
    AppendProperty property ->
      property
        |> processProperty config
        |> List.map AppendProperty
        |> ApplyMixins

    ExtendSelector selector mixins ->
      mixins
        |> List.map (processMixin config)
        |> ExtendSelector selector

    NestSnippet combinator snippets ->
      snippets
        |> List.map (processSnippet config)
        |> NestSnippet combinator

    WithPseudoElement pseudo mixins ->
      mixins
        |> List.map (processMixin config)
        |> WithPseudoElement pseudo

    WithMedia queries mixins ->
      mixins
        |> List.map (processMixin config)
        |> WithMedia queries

    ApplyMixins mixins ->
      mixins
        |> List.map (processMixin config)
        |> ApplyMixins


anyOverlap : List BrowserRange -> List BrowserRange -> Bool
anyOverlap config local =
  List.any (\range -> List.any (\other -> BrowserRange.overlaps range other) config) local


processProperty : Config -> Property -> List Property
processProperty config property =
  let
    keyProps =
      Dict.get property.key keyTransforms
        |> Maybe.withDefault []
        |> List.filter (.ranges >> (anyOverlap config))
        |> List.concatMap (.operation >> (Transform.execute property))
  in
    List.concat [keyProps, [property]]
