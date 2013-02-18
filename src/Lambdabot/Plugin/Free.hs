{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses #-}
-- | Free theorems plugin
-- Andrew Bromage, 2006
module Lambdabot.Plugin.Free where

import Lambdabot.Plugin
import Lambdabot.Plugin.Free.FreeTheorem
import Lambdabot.Plugin.Type (query_ghci)

$(plugin "Free")

instance Module FreeModule () where
    moduleCmds _  = ["free"]
    moduleHelp _ _= "free <ident>. Generate theorems for free"
    process_ _ _ xs = do result <- freeTheoremStr (liftM unlines . lift . query_ghci ":t") xs
                         return . (:[]) . concat . intersperse " " . lines $ result
