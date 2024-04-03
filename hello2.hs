newtype Html = Html String
newtype Structure = Structure String

type Title = String

main = putStrLn myHtml

myHtml = 
  makeHtml 
    "Hello title" 
    (h1_ "hello h1" <> p_ "hello p")

makeHtml title content = html_ (head_ (title_ title) <> body_ content)

head_ :: String -> String
head_ = el "head"

body_ :: String -> String
body_ = el "body"

title_ :: String -> String
title_ = el "title"

html_ :: String -> String
html_ = el "html"

h1_ :: String -> String
h1_ = el "h1"

p_ :: String -> String
p_ = el "p"


el :: String -> String -> String
el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"


-- Notas
-- por defecto recibe un parametro
-- las funciones por defecto son clases

append_ :: Structure -> Structure -> Structure
append_ (Structure aux) (Structure aux2) = 
   Structure ( aux <> aux2)


render :: Html -> String
render html = 
  case html of 
    Html str -> str