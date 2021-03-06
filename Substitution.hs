module Substitution ( Subst(Subst)
                    , Pretty
                    , pretty
                    , empty
                    , single
                    , apply
                    , compose
                    , restrictTo
                    ) where

import Data.List  (intercalate)
import Data.Maybe (isNothing)

import Pretty
import Type
import Vars

-- Data type for substitutions.
data Subst = Subst [(VarName, Term)]
  deriving Show

-- Pretty instance for substitutions.
instance Pretty Subst where
    pretty subst = "{" ++ (intercalate ", " (prettyHelp subst))  ++ "}"
        where prettyHelp :: Subst -> [String]
              prettyHelp (Subst []) = []
              prettyHelp (Subst ((svName, sTerm):xs)) = (svName ++ " -> " ++ (pretty sTerm)) : (prettyHelp (Subst xs))

-- Vars instance for substitutions.
instance Vars Subst where
    allVars (Subst []) = []
    allVars (Subst ((svName, sTerm):xs)) = svName : (allVars sTerm) ++ allVars (Subst xs)

-- The empty substitution.
empty :: Subst
empty = Subst []

-- A substitution that only changes one variable into a different term.
single :: VarName -> Term -> Subst
single vName term = Subst [(vName, term)]


-- Applys a substitution to a term
apply :: Subst -> Term -> Term
apply (Subst []) term = term
apply (Subst ((svName, sTerm):xs)) (Var vName)
    | svName == vName = sTerm
    | otherwise = (apply (Subst xs) (Var vName))
apply subst (Comb cName cTerm) = (Comb cName (map (apply subst) cTerm))

-- Composes two substitutions into one.
compose :: Subst -> Subst -> Subst
compose (Subst s2) (Subst s1) =
  let s3 = [ (n2, t2) | (n2, t2) <- s2, isNothing (lookup n2 s1)]
  in Subst (s3 ++ [(v1, (apply (Subst s3) t1)) | (v1, t1) <- s1])

-- Restricts a substitution to only contain tuples with variables
-- contained in the list of variable names.
restrictTo :: [VarName] -> Subst -> Subst
restrictTo xs (Subst ts1) = Subst [(v2Name,t) | v1Name <- xs, (v2Name, t) <- ts1, v1Name == v2Name]
