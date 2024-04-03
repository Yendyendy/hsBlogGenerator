-- nombre del modulo en MAYUSCULA
module Html
    ( Html
    , Title
    , Structure
    , html_
    , p_
    , h1_
    , append_
    , render
    )
    where

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
render :: Html -> String
render html = 
    case html of
        Html str -> str

-- getStructureString
getStructureString :: Structure -> String
getStructureString content =
    case content of
        Structure str -> str 