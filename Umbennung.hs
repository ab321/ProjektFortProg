import Substitution
import Type
import Vars
import Pretty

rename :: Goal -> Rule -> Rule
rename g (Rule t ts) = rename' (allVars g) (freshVars) (t:ts) 
 where
    rename' :: [VarName] -> [VarName] -> [Term] -> Rule
    rename'  []     _  (t:ts)  = Rule t ts
    rename' (v:vs) (u:us) ts   = rename' vs us (map(apply(single v (Var u)))ts)


-- cName1 /= cName2 || (length cTerm1) /= (length cTerm2)



a = (Goal [Var "A",Var "B",Var"B",Var "C"])
b = (Rule (Var "_") [Var "B", Var "Q",Comb "."[Var "A" , Comb "[]" []]])


--Goal [t]                    t                  ts
--f(X,Y,Z)                -> f(X,Y,Z)     :- .....
--Goal [t1,t2]                    t1      :-      t1s     ,  t2 :- t2s
--f(X,Y,Z) , g(X,K,L)



 import Control.Monad.State
 import Vars
 import Type
 
 type MyState = [(VarName, VarName)]
 
 valFromState :: MyState -> VarName
 valFromState v = let usedVars = snd (unzip v)
                  in vhelp' usedVars freshVars
 vhelp' :: [VarName] -> [VarName] -> VarName
 vhelp' usedVars (x:xs) = if elem x usedVars then vhelp' usedVars xs else x
 
 
 
 nextState :: MyState -> VarName -> VarName -> MyState
 nextState state newVar assignedVar = (newVar, assignedVar) : state
 
 type MyStateMonad = State MyState
 
 getNext :: VarName -> MyStateMonad VarName
 getNext newVar = state (\st -> let 
                                    oldVal = valFromState st
                                    st' = nextState st newVar oldVal 
                                in (valFromState(st'), st') )
 

 
 mystate :: MyStateMonad VarName
 mystate = do x <- getNext "A"    [("A", "_1")]
              z <- getNext "B"    
              y <- getNext "C"
              newD <- getNext "_" ("_", "__1")
                  
              return z
