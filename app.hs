{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import           Data.CaseInsensitive (mk)
import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)
import Html ( rendercan, Html, append_, p_, h1_, html_ )
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
index_ :: Html
index_ = 
    html_
        "Haskell web"
        ( append_
                (h1_ "Haskell Blog Generator")
                (append_
                    (p_ "Paragraph 1")
                    (p_ "Paragraph 2")
                )
        )

indexCharacter_ :: Html
indexCharacter_ = 
    html_
        "Characters"
        ( append_
                (h1_ "Haskell Blog Generator")
                (p_ "Paragraph 1")
                
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