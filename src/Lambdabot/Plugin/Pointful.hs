{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, TypeSynonymInstances #-}
-- Undo pointfree transformations. Plugin code derived from Pl.hs.
module Lambdabot.Plugin.Pointful (theModule) where

import Lambdabot.Plugin

import Lambdabot.Utils.Pointful

type PfState = ()

$(plugin "Pointful")

--type Pf = ModuleLB PfState

instance Module PointfulModule PfState where

    moduleCmds _ = ["pointful","pointy","repoint","unpointless","unpl","unpf"]

    moduleHelp _ _ = "pointful <expr>. Make code pointier."

    moduleDefState _ = return $ ()

    process _ _ _ _ rest = return (lines $ pointful rest)
