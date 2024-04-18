{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import           Data.CaseInsensitive (mk)
import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)
import Html.Internal 
import Basement.Block (index)

app :: Application
app request respond = do
        putStrLn "app request"
        respond $ case rawPathInfo request of
            "/"             -> plainIndex
            "/characters/"  -> plainCharacters
            _               -> notFound

plainIndex :: Response
plainIndex = responseLBS
    status200
    [(mk $ B8.pack "Content-Type", B8.pack "text/html")]
    (LB8.pack (rendercan index_))

plainCharacters :: Response
plainCharacters = responseLBS
    status200
    [(mk $ B8.pack "Content-Type", B8.pack "text/html")]
    (LB8.pack (rendercan indexCharacter_))

notFound :: Response
notFound = responseLBS
    status404
    [(mk $ B8.pack "Content-Type", B8.pack "text/html")]
    (LB8.pack (rendercan indexNotFound_))

-- index_
-- index_ :: Html
-- index_ = 
--     html_
--         "Haskell web"
--         ( append_
--                 (h1_ "Haskell Blog Generator")
--                 (append_
--                     (p_ "Paragraph 1")
--                     (append_
--                         (p_ "Paragraph 2")
--                         (code_ "putStrLn = 'Hello Word'")
--                     )
--                 )
--         )

index_ = 
    html_
        "Haskell web"
        ( h_ 1 "Haskell Blog Generator"
            <> p_ "Paragraph 1"
            <> ( p_ "Paragraph 2"
                <> code_ "putStrLn ) 'Hello Word' >>="
            )
        )

indexCharacter_ :: Html
indexCharacter_ = 
    html_
        "Characters"
        (append_
            ( append_
                (h1_ "BA favourite")
                (ul_ [p_"Toki", p_"Yuuka", p_"Azusa", p_"Neru"]) 
            )
            ( append_
                (h1_ "BA story favourite")
                (ol_ [p_"Aris", p_"Hoshino", p_"Aru", p_"Koharu", p_"Yuzu"]) 
            )

        )

indexNotFound_ :: Html
indexNotFound_ = 
    html_
        "Haskell web" 
        (h1_ "Not found 404")  

main :: IO ()
main = do
    putStrLn $ "http://localhost:8080/"
    run 8080 app