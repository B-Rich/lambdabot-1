{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses #-}
-- | Free theorems plugin,
-- Don Stewart 2006
module Lambdabot.Plugin.FT where

import Lambdabot.Plugin
import Lambdabot.Plugin.Type (query_ghci)

$(plugin "FT")

instance Module FTModule () where
    moduleCmds _   = ["ft"]
    moduleHelp _ _ = "ft <ident>. Generate theorems for free"
    process_ _ _ s = (liftM unlines . lift . query_ghci ":t") s >>= ios . ft

binary :: String
binary = "ftshell"

ft :: String -> IO String
ft src = run binary src $
    unlines . map (' ':) . filter (not.null) . map cleanit . lines

cleanit :: String -> String
cleanit s | terminated `matches'` s = "Terminated\n"
          | otherwise               = filter isAscii s
    where terminated = regex' "waitForProc"
