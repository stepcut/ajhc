module FrontEnd.Tc.Type(
    fn,
    HasKind(..),
    Kind(..),
    Pred(..),
    MetaVar(..),
    MetaVarType(..),
    tForAll,
    module FrontEnd.Tc.Type,
    Qual(..),
    Tycon(..),
    Type(..),
    tyvar,
    tList,
    Tyvar(..)
    ) where

import Control.Monad.Writer
import Data.IORef
import List

import Doc.DocLike
import Doc.PPrint
import Name.Names
import Name.VConsts
import Representation hiding(flattenType, findType)
import Type(HasKind(..))
import Support.Unparse
import Util.VarName

type Box = IORef (Maybe Type)
type Sigma' = Sigma
type Tau' = Tau
type Rho' = Rho
type Sigma = Type
type Rho = Type
type Tau = Type

type MetaTV = Tyvar
type SkolemTV = Tyvar
type BoundTV = Tyvar

isMetaTV :: Tyvar -> Bool
isMetaTV Tyvar { tyvarRef = Just _ } = True
isMetaTV _ = False


{-
openBox :: MonadIO m => Box -> m (Maybe Sigma)
openBox x = liftIO $ readIORef x

fillBox :: MonadIO m => Box -> Type -> m ()
fillBox x t  = liftIO $ do
    t <- flattenType t
    when (isBoxy t) $ error "filling with boxes"
    ct <- readIORef x
    case ct of
        Just _ -> fail "box is already filled"
        Nothing -> writeIORef x (Just t)
fillBox x t = error "attempt to fillBox with boxy type"
-}

isTau :: Type -> Bool
isTau TForAll {} = False
isTau TBox {} = error "isTau: Box"
isTau (TAp a b) = isTau a && isTau b
isTau (TArrow a b) = isTau a && isTau b
isTau (TMetaVar MetaVar { metaType = t })
    | t == Tau = True
    | otherwise = False
isTau _ = True

isTau' :: Type -> Bool
isTau' TForAll {} = False
isTau' TBox {} = error "isTau': Box"
isTau' (TAp a b) = isTau a && isTau b
isTau' (TArrow a b) = isTau a && isTau b
isTau' _ = True

isBoxy :: Type -> Bool
isBoxy TBox {} = error "isBoxy: Box"
isBoxy (TMetaVar MetaVar { metaType = t }) | t > Tau = True
isBoxy (TForAll _ (_ :=> t)) = isBoxy t
isBoxy (TAp a b) = isBoxy a || isBoxy b
isBoxy (TArrow a b) = isBoxy a || isBoxy b
isBoxy _ = False

isRho' :: Type -> Bool
isRho' TForAll {} = False
isRho' _ = True

isRho :: Type -> Bool
isRho r = isRho' r && not (isBoxy r)


isBoxyMetaVar MetaVar { metaType = t } = t > Tau

fromTAp t = f t [] where
    f (TAp a b) rs = f a (b:rs)
    f t rs = (t,rs)

--extractMetaTV :: Monad m => Type -> m MetaTV
--extractMetaTV (TVar t) | isMetaTV t = return t
--extractMetaTV t = fail $ "not a metaTyVar:" ++ show t

extractTyVar ::  Monad m => Type -> m Tyvar
extractTyVar (TVar t) | not $ isMetaTV t = return t
extractTyVar t = fail $ "not a Var:" ++ show t

extractMetaVar :: Monad m => Type -> m MetaVar
extractMetaVar (TMetaVar t)  = return t
extractMetaVar t = fail $ "not a metaTyVar:" ++ show t

extractBox :: Monad m => Type -> m MetaVar
extractBox (TMetaVar mv) | metaType mv > Tau  = return mv
extractBox t = fail $ "not a metaTyVar:" ++ show t


prettyPrintType :: DocLike d => Type -> d
prettyPrintType t  = unparse $ runVarName (f t) where
    arr = bop (R,0) (space <> text "->" <> space)
    app = bop (L,100) (text " ")
    fp (IsIn cn t) = do
        t' <- f t
        return (atom (text $ show cn) `app` t')
    f (TForAll [] ([] :=> t)) = f t
    f (TForAll vs (ps :=> t)) = do
        ts' <- mapM (newLookupName ['a'..] ()) vs
        t' <- f t
        ps' <- mapM fp ps
        return $ case ps' of
            [] ->  fixitize (N,-3) $ pop (text "forall" <+> hsep (map char ts') <+> text ". ")  (atomize t')
            [p] -> fixitize (N,-3) $ pop (text "forall" <+> hsep (map char ts') <+> text "." <+> unparse p <+> text "=> ")  (atomize t')
            ps ->  fixitize (N,-3) $ pop (text "forall" <+> hsep (map char ts') <+> text "." <+> tupled (map unparse ps) <+> text "=> ")  (atomize t')
    f (TCon tycon) = return $ atom (pprint tycon)
    f t | Just tyvar <- extractTyVar t = do
        vo <- maybeLookupName tyvar
        case vo of
            Just c  -> return $ atom $ char c
            Nothing -> return $ atom $ tshow (tyvarAtom tyvar)
    f (TAp (TCon (Tycon n _)) x) | n == tc_List = do
        x <- f x
        return $ atom (char '[' <> unparse x <> char ']')
    f ta@(TAp {}) | (TCon (Tycon c _),xs) <- fromTAp ta, Just _ <- fromTupname c = do
        xs <- mapM f xs
        return $ atom (tupled (map unparse xs))
    f (TAp t1 t2) = do
        t1 <- f t1
        t2 <- f t2
        return $ t1 `app` t2
    f (TArrow t1 t2) = do
        t1 <- f t1
        t2 <- f t2
        return $ t1 `arr` t2
    f (TMetaVar mv) = return $ atom $ pprint mv
    f (TBox Star i _) = return $ atom $ text "_" <> tshow i
    f t | ~(TBox k i _) <- t = return $ atom $ parens $ text "_" <> tshow i <> text " :: " <> pprint k


instance DocLike d => PPrint d MetaVarType where
    pprint  t = case t of
        Tau -> char 't'
        Rho -> char 'r'
        Sigma -> char 's'

instance DocLike d => PPrint d MetaVar where
    pprint MetaVar { metaUniq = u, metaKind = k, metaType = t }
        | Star <- k =  pprint t <> tshow u
        | otherwise = parens $ pprint t <> tshow u <> text " :: " <> pprint k



data UnVarOpt = UnVarOpt {
    openBoxes :: Bool,
    failEmptyMetaVar :: Bool
    }

flattenMetaVars t = unVar UnVarOpt { openBoxes = False, failEmptyMetaVar = False } t
flattenType t =  unVar UnVarOpt { openBoxes = True, failEmptyMetaVar = False } t


class UnVar t where
    unVar' ::  UnVarOpt -> t -> IO t

unVar :: (UnVar t, MonadIO m) => UnVarOpt -> t -> m t
unVar opt t = liftIO (unVar' opt t)

instance UnVar t => UnVar [t] where
   unVar' opt xs = mapM (unVar' opt) xs

instance UnVar Pred where
    unVar' opt (IsIn c t) = IsIn c `liftM` unVar' opt t

instance UnVar t => UnVar (Qual t) where
    unVar' opt (ps :=> t) = liftM2 (:=>) (unVar' opt ps) (unVar' opt t)

instance UnVar Type where
    unVar' opt tv =  do
        let ft (TAp x y) = liftM2 TAp (unVar' opt x) (unVar' opt y)
            ft (TArrow x y) = liftM2 TArrow (unVar' opt x) (unVar' opt y)
            ft t@TCon {} = return t
            ft (TForAll vs qt) = do
                when (any isMetaTV vs) $ error "metatv in forall binding"
                qt' <- unVar' opt qt
                return $ TForAll vs qt'
            ft t@TBox { typeBox = box }
                | openBoxes opt =  readIORef box >>= \x -> case x of
                    Just x -> unVar' opt x
                    Nothing -> error "unVar: empty box"
                | otherwise = return t
            ft t@(TMetaVar _) = if failEmptyMetaVar opt then fail $ "empty meta var" ++ prettyPrintType t else return t
            --ft t | Just tv <- extractMetaTV t = if failEmptyMetaVar opt then fail $ "empty meta var" ++ prettyPrintType t else return (TVar tv)
            ft t | ~(Just tv) <- extractTyVar t  = return (TVar tv)
        tv' <- findType tv
        ft tv'



findType :: MonadIO m => Type -> m Type
findType tv@(TMetaVar MetaVar {metaRef = r }) = liftIO $ do
    rt <- readIORef r
    case rt of
        Nothing -> return tv
        Just t -> do
            t' <- findType t
            writeIORef r (Just t')
            return t'
findType tv = return tv


freeTyVars :: Type -> [Tyvar]
freeTyVars t = filter (not . isMetaTV) $ allFreeVars t

allFreeVars (TVar u)      = [u]
allFreeVars (TAp l r)     = allFreeVars l `union` allFreeVars r
allFreeVars (TArrow l r)  = allFreeVars l `union` allFreeVars r
allFreeVars TCon {}       = []
allFreeVars TBox {}       = []
allFreeVars typ | ~(TForAll vs (_ :=> t)) <- typ = allFreeVars t List.\\ vs

freeMetaVars :: Type -> [MetaVar]
freeMetaVars (TVar u)      = []
freeMetaVars (TAp l r)     = freeMetaVars l `union` freeMetaVars r
freeMetaVars (TArrow l r)  = freeMetaVars l `union` freeMetaVars r
freeMetaVars TCon {}       = []
freeMetaVars TBox {}       = []
freeMetaVars (TMetaVar mv) = [mv]
freeMetaVars typ | ~(TForAll vs (_ :=> t)) <- typ = freeMetaVars t


-- returns (new type, any open boxes, any open tauvars)
unbox :: MonadIO m => Type -> m (Type,Bool,Bool)
unbox tv = do
    let ft (TAp x y) = liftM2 TAp (ft' x) (ft' y)
        ft (TArrow x y) = liftM2 TArrow (ft' x) (ft' y)
        ft t@TCon {} = return t
        ft (TForAll vs (ps :=> t)) = do
            when (any isMetaTV vs) $ error "metatv in forall binding"
            ps' <- sequence [ ft' t >>= return . IsIn c | ~(IsIn c t) <- ps ]
            t' <- ft' t
            return $ TForAll vs (ps' :=> t')
        ft t@(TMetaVar mv)
            | isBoxyMetaVar mv = tell ([True],[]) >> return t
            | otherwise =  tell ([],[True]) >> return t
        ft t | ~(Just tv) <- extractTyVar t  = return (TVar tv)
        ft' t = findType t >>= ft
    (tv,(eb,et)) <- runWriterT (ft' tv)
    return (tv,or eb, or et)
