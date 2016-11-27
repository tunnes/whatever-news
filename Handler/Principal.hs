{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable, EmptyDataDecls,
             GeneralizedNewtypeDeriving, ViewPatterns, FlexibleInstances #-} -- Importante quando se usa QuasiQuoters

module Handler.Principal where

import Foundation
import Yesod
import Text.Julius
import Data.Text
import Yesod.Static
import System.FilePath
import Data.Maybe (fromMaybe)

getPrincipalR :: Handler Html
getPrincipalR = do
    (n1:n2:n3:ns) <- runDB $ selectList [] [Desc NoticiaData, LimitTo 9]
    (i1:_:i3:_) <- runDB $ selectList [] [Desc ImagemId, LimitTo 3]
    defaultLayout $ do
        addScript (StaticR julius_principal_js)
        $(whamletFile "Templates/principal.hamlet")
    where
        diretorio = "static/img/"