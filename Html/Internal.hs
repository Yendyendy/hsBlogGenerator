module Html.Internal where

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

-- el 
el :: String -> String -> String
el tag content = 
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

-- append
append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = 
    Structure (a <> b)

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
