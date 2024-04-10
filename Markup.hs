
module Markup
(
  Document
  , Structure(..)
  , parse
)
where

import Numeric.Natural
import Data.Maybe (maybeToList) 
type Document
  = [Structure]

data Structure
  = Heading Natural String
  | Paragraph String
  | UnorderedList [String]
  | OrderedList [String]
  | CodeBlock [String]
  deriving(Eq, Show)

-- -- Hello, world!
-- ex1 :: Document
-- ex1 = 
--     [ Paragraph "Hello, world!"
--     ]

-- ex2 :: Document
-- ex2 = 
--     [ Heading 1 "Welcome"
--     , Paragraph "To this tutorial about Haskell."
--     ]

-- ex3 :: Document
-- ex3 = 
--     [ Paragraph "Remember that multiple lines with no separation are grouped together into a single paragraph but list items remain separate."
--     , UnorderedList
--         [ "Item 1 of a list"
--         , " Item 2 of the same list"
--         ]
--     ]

-- ex4 = 
--     [ Heading 1 "Compiling programs with ghc"
--     , Paragraph "Running ghc invokes the Glasgow Haskell Compiler (GHC), and can be used to compile Haskell modules and programs into native executables and libraries."
--     , Paragraph "Create a new Haskell source file named hello.hs, and write the following code in it:"
--     , CodeBlock ["main = putStrLn \"Hello, Haskell!\""]
--     , Paragraph "Now, we can compile the program by invoking ghc with the file name:"
--     , CodeBlock 
--         [ "➜ ghc hello.hs"
--         , "[1 of 1] Compiling Main             ( hello.hs, hello.o )"
--         , "Linking hello ..."
--         ]
--     , Paragraph "GHC created the following files:"
--     , UnorderedList 
--         [ "hello.hi - Haskell interface file"
--         , "hello.o - Object file, the output of the compiler before linking"
--         , "hello (or hello.exe on Microsoft Windows) - A native runnable executable."
--         ]
--     , Paragraph "GHC will produce an executable when the source file satisfies both conditions:"
--     , OrderedList
--         [ "Defines the main function in the source file"
--         , "Defines the module name to be Main or does not have a module declaration"
--         ]
--     , Paragraph "Otherwise, it will only produce the .o and .hi files."
--     ]

parse :: String -> Document
parse = parseLines Nothing . lines

trim = unwords . words 

parseLines :: Maybe Structure -> [String] -> Document
parseLines context texts = 
  case texts of
    [] -> maybeToList context

    ('*': ' ' : line) : rest ->
      maybe id (:) context (Heading 1 line : parseLines Nothing rest)
    ('-' : ' ' : line) : rest ->
      case context of
        Just(UnorderedList uls) -> 
          parseLines (Just (UnorderedList (line : uls))) rest
        _ ->
          maybe id (:) context (parseLines (Just (UnorderedList [trim line])) rest)
    currentLine : rest -> 
      if trim currentLine == ""
        then maybe id (:) context (parseLines Nothing rest)
        else
          case context of
            Just ( Paragraph t) -> 
              parseLines (Just(Paragraph (unwords [t, currentLine]))) rest
            _ -> 
              maybe id (:) context (parseLines (Just (Paragraph currentLine)) rest)









