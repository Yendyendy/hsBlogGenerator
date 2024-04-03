import Prelude ( IO, putStrLn )
import Html

main :: IO ()
main = putStrLn (render myHtml)

-- myHtml
myHtml :: Html
myHtml = 
    html_
        "Title"
        ( append_
                (h1_ "h1")
                (append_
                    (p_ "Paragraph 1")
                    (p_ "Paragraph 2")
                )
        )