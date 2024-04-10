
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


-- funcionRecursiva :: (Ord t, Num t, Num [t]) => t -> [t]
-- funcionRecursiva x = 
--     if x <= 0
--         then []
--         else x : funcionRecursiva x-1

-- -- convertirTextoAArrayLinea = line
-- -- dado line recorrer 
-- si no llega a EOF, sigue haciendo recursiva
-- si no llega a n +1, siendo n el número de lineas, recursiva

--
--lines me devuelve ["", "" ... ""]
--ahora trabajar con el array
--
--
--como vimos en el ejemplo de ul
--
--map . getStructure
--
--pero esto es diferente,
--con map composición getStrcture, como map apli
--pero esto es un poco diferente, o no
--
--si es diferente, porque lo que quiero hacer ¿qué es no lo se jeje?
--
--mejor dicho, lo que hace map, me lo hace lines para string
--
--entonces que, entonces tengo con lines, que es una especie de map lo que quiero
--
--ahora tengo que recorrer la lista para meterlo en un array nuevo pero en forma de paragraph
--
--String -> Document
--String -> [data Structure]
--
--String + lines -> [String]
--
--[String] + () -> [data Structure]





--parse texto = lines texto



--we first need to understand the code 
--befor we start lets see what we now and want to do
  --if we see the code we know that we have a text as string
    --then we turn it in to lines 
    --i  want to know what return lines in case that there is \n between paragraphs 

--"* Compiling programs with ghc\n\nRunning ghc invokes the Glasgow 
--Haskell Compiler (GHC),\nand can be used to compile Haskell modules 
--and programs into native\nexecutables and libraries.\n"

--["* Compiling programs with ghc",
  --"",
  --"Running ghc invokes the Glasgow Haskell Compiler (GHC),",
  --"and can be used to compile Haskell modules and programs into native","executables and libraries."
--]

--so as what we can see the lines slipt the string, use \n as token 
--and return "" when there is al empty line 

--ok, now our objective is to append diferent strings in one to have an paragraph
--can we do it?

--we are going to do one type of document at once and then add all the cases toghether 
--i think this is the best

--so what things we have now?
--we have lines text

--parse text = lines text

--ok so we have string -> [string]

--then we need to do recursion

--read all elements from an string linked list

--read =
  --[] -> aaa 
  --first : rest -> read rest

--so now we have an recursion 
--that read all the elements from text
--let say [1,2,3,4]
--[2,3,4]
--[3,4]
--[4]
--[]
--that  is what we have, 
--but we dont know what to do at the end 
--OHHHHHHHHHHHHHHHHHHHH
--so we return Paragraph nothing
--then we append? 
--i dont know

--note, "" means that there ends the paragraph
--so when we meet "" we can finish the paragraph

--so has [string] we want to return paragraph
--we need to append all the string until we meet "" 

--how can we do that?


--read context txt=
  --[] -> Paragraph "" --return empty 
  --first : rest -> 
    --if first == ""
      --then Paragraph first--end 
      --else 
        --first : (read rest txt)

--i have a question, wtf is the context

--i think i start to understand a little more

--there is diferent between the current [] as element
--and the [] as all

--so the context is what you have at start, empty to fill with data,
--and when "" comes, append to the strat of the return array

--there is an invisible return array 

--so we want to do that we need some changes 
--code the append when some paragraph ends,

--as the pita teach us, we need to see the recursive function as the 
--result of the data

--so we need to see read context txt as an array [] with all the paragraphs
--we pass context to help us
--i dont know if there is something in the order of the arrays 



--read context txt=
  --[] -> Paragraph "" --return empty 
  --first : rest -> 
    --if first == ""
      --then Paragraph first--end 
      --else 
        --first : (read rest txt)

--in that case we concat in else the first as the elemt of the return []
--and when "" comes, we construct a paragraph wich is rare
--i mean, wtf that will return ?
--there is no like a return rigth?

--ummm, it ends with the [] -> case, because it end of the data, 
--ok now i understand the firts parse example 
 
-- test = aaa
-- aaa = parse [] . lines

-- parse :: [String] -> [String] -> [Structure]
-- parse current txt = 
  -- case txt of
    -- [] -> [Paragraph (unlines current)]
    -- item : rest ->
      -- if trim item == ""
        -- then Paragraph (unlines current) : parse [] rest
        -- else parse ( item : current ) rest

-- trim = unwords . words

-- test2 = parse2
-- parse2= parseLines [] . lines

-- parseLines :: [String] -> [String] -> Document
-- parseLines currentParagraph txts =
  -- let
    -- paragraph = Paragraph (unlines (reverse currentParagraph))
  -- in
    -- case txts of
      -- [] -> [paragraph]
      -- currentLine : rest ->
        -- if trim currentLine == ""
          -- then
            -- paragraph : parseLines [] rest
          -- else 
            -- parseLines (currentLine : currentParagraph) rest





parse :: String -> Document
parse = parseLines Nothing . lines

trim = unwords . words 

--parseLines :: [String] -> [String] -> Document
--parseLines context texts =
  --let 
    --ph = Paragraph (unlines (reverse context))
  --in 
    --case texts of
      --[] -> [ph]
      --currentLine : rest ->
        --if trim currentLine == ""
          --then ph : parseLines [] rest 
          --else parseLines (currentLine : context) rest 


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









