module Css.Autoprefix.Utils
  ( mapBaseName
  , stringReplace
  ) where

import Regex exposing (Regex, regex, replace)

unprefixRegex : Regex
unprefixRegex =
  regex "(?:-(?:ms|o|webkit|moz)-)?(.*)"


mapBaseName : (String -> String) -> String -> String
mapBaseName transformer input =
  Regex.replace
    (Regex.AtMost 1)
    (unprefixRegex)
    (\{ match } -> transformer match)
    (input)


stringReplace : String -> String -> String -> String
stringReplace find replace input =
  Regex.replace
    (Regex.All)
    (regex (Regex.escape find))
    (always replace)
    (input)
