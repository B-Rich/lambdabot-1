--
-- | Let's go lambdabot!
--
module Main where

import Lambdabot.LMain
import Lambdabot.Modules      (modulesInfo)
import Lambdabot.Lambdabot

import Data.Maybe
import System.Posix.Signals

-- do argument handling
main :: IO ()
main = do
    -- when 'popen' is called on a non-existing executable, SIGPIPE is sent,
    -- causing lambdabot to exit:
    installHandler sigPIPE Ignore Nothing
    main' Nothing modulesInfo

-- special online target for ghci use
online :: [String] -> IO ()
online strs = runIrc strs (fst modulesInfo) ld pl
    where
    ld = fromMaybe (error "no dynamic loading") Nothing
    pl = []
