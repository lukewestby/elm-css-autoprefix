module Css.Autoprefix.Utils
  ( mapBaseName
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
