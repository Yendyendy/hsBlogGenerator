main = putStrLn myhtml2

-- wrapHtml content = "<html><body>" <> content <> "</body></html>"
-- myhtml = wrapHtml "Hello, world!"


-- ejer 1 
html_ content = "<html>" <> content <> "</html>"
body_ content = "<body>" <> content <> "</body>"

-- ejer 2
-- myhtml = html_ ( body_ "My page title" )
myhtml = html_ ( body_ "My page title" )


-- ejer 3
head_ content = "<head>" <> content <> "</head>"
title_ content = "<title>"  <> content <> "</title>"

-- ejer 4 
makeHtml title content = html_ (head_ (title_ title) <> body_ content) 
 
myhtml2 = makeHtml "Hello title" "Hello, world!"

