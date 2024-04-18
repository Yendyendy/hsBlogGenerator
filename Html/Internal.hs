module Html.Internal where
import Numeric.Natural

newtype Html = Html String
newtype Structure = Structure String
type Title = String

-- html
html_ :: Title -> Structure -> Html
html_ title content = 
    Html
        (
            el "Html" 
                (
                    el "head" (el "title" title)
                    <> el "body" (getStructureString content)
                )
        ) 

-- p
p_ :: String -> Structure
p_ = Structure . el "p"

-- h1
h1_ :: String -> Structure
h1_ = Structure . el "h1"

h_ :: Natural -> String -> Structure
h_ n = 
    Structure . el ("h" <> show n) . escape

-- el 
el :: String -> String -> String
el tag content = 
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

-- append
append_ :: Structure -> Structure -> Structure
append_ c1 c2 =
  Structure (getStructureString c1 <> getStructureString c2)

-- render
rendercan :: Html -> String
rendercan html = 
    case html of
        Html str -> str

-- getStructureString
getStructureString :: Structure -> String
getStructureString content =
    case content of
        Structure str -> str 

escape :: String -> String
escape = 
    let 
        escapeChar c =
            case c of 
                '<' -> "&lt;"
                '>' -> "&gt;"
                '&' -> "&amp;"
                '"' -> "&quot;"
                '\'' -> "&#39;"
                _ -> [c]
    in concat . map escapeChar

ul_ :: [Structure] -> Structure
ul_ =
    Structure .el "ul" . concat . map (el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_= 
    Structure . el "ol" . concat . map (el "li". getStructureString)

code_ :: String -> Structure
code_ =
    Structure . el "pre" . escape


empty_ :: Structure 
empty_ = Structure ""


concatStructure :: [Structure] -> Structure
concatStructure list =
    case list of
        [] -> empty_
        x : xs -> x <> concatStructure xs 


instance Semigroup Structure where
  (<>) c1 c2 =
    Structure (getStructureString c1 <> getStructureString c2)
