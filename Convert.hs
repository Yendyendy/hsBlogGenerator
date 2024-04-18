module Convert where

import qualified Markup
import qualified Html
import qualified GHC.Exts.Heap as Html

convertStructure structure = 
    case structure of
        Markup.Heading n txt -> 
            Html.h_ n txt 

        Markup.Paragraph p ->
            Html.p_ p
        
        Markup.UnorderedList list ->
            Html.ul_ $ map Html.p_ list

        Markup.OrderedList list ->
            Html.ol_ $ map Html.p_ list
        
        Markup.CodeBlock list ->
            Html.code_ (unlines list)