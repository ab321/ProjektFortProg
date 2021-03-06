




--subst1 = (Subst [("A", Comb "f" [Var "B", Var "_", Comb "true" []]),("D", Comb "false" [])])
--subst2 = (Subst [("B", Comb "false" [])])
--term1 =  (Comb "." [Var "K",Comb "." [Var "L",Var "A",Var "B", Var "B"]])

--pretty1 = pretty (apply subst1 term1)



--vars    = ["A","B","C"]
--substs  = Subst [("A",Var "B"),("X",Var "B"),("C",Var "B")]

--subst1 = (single "B" (Comb "g" [Var "A", Var "C"]))
--subst2 = (single "B" (Comb "f" [Var "C"]))
--composit = subst2 `compose` subst1


--compsubst = (single "A" (Var "B"))
-- comptest = compsubst `compose` compsubst



{--

appendrule1 = Rule (Comb "append" [Comb "[]" [], Var "L", Var "L"]) []
appendrule2 = Rule (Comb "append" [Comb "." [Var "E", Var "R"],Var "L",Comb "." [Var "E", Var "RL"]]) [Comb "append" [Var "R", Var "L", Var "RL"]]

appendrule1term = (Comb "append" [Comb "[]" [], Var "L", Var "L"])
appendrule2term = (Comb "append" [Var "R", Var "L", Var "RL"])

test123 = apply (fromJust (unify (head appendgoal) appendrule1term)) (head appendgoal)
test1232 = apply (fromJust (unify (head appendgoal) appendrule2term)) (head appendgoal)

appendgoal = [(Comb "append" [Var "_", Var "Y", Comb "." [Comb "1" [], Comb "2" []]])]



-- append([],L,L).
-- append([E|R],L,[E|RL]) :- append(R,L,RL).


appendgoal   = (parse "append(_,Y,[1,2]).") :: Either String Goal

appendprog = Prog (appendrule1 : appendrule2 : [])

goaltest  = Goal [(Comb "p" [Var "S", Comb "b" []])]
goaltest2 = Goal [(Comb "p" [Var "_", Comb "b" []])]
goaltest3  = Goal [(Comb "p" [Var "_", Var "S"])]
goaltest4  = Goal [(Comb "p" [Var "_0", Comb "b" []])]
goaltest5 = Goal [(Comb "p" [Var "_", Var "_"])]

progtest = Prog [ (Rule (Comb "p" [Var "X", Var "Z"]) [(Comb "q" [Var "X", Var "Y"]), (Comb "p" [Var "Y", Var "Z"])] ),
                  (Rule (Comb "p" [Var "X", Var "X"]) []),
                  (Rule (Comb "q" [Comb "a" [], Comb "b" []]) []) ]
--}


--appendprog = do x <- (parseFile "append.pl") :: IO (Either String Prog)
--                let y = (fromRight (Prog []) x)
--                let z =


subst11 = (Subst [("A", Comb "f" [Var "B", Var "_", Comb "true" []]),("D", Comb "false" [])])
subst12 = (Subst [("B", Comb "false" [])])
term1 =  (Comb "." [Var "K",Comb "." [Var "L",Var "A",Var "B", Var "B"]])

pretty1 = pretty (apply subst1 term1)

vars    = ["A","B","C"]
substs  = Subst [("A",Var "B"),("X",Var "B"),("C",Var "B")]

subst1 = (single "B" (Comb "g" [Var "A", Var "C"]))
subst2 = (single "B" (Comb "f" [Var "C"]))
composit = subst2 `compose` subst1


subst3 = Subst [("A", Comb "f" [Comb "x" []]),("B", Comb "true" []),("C", Comb "c" [Var "E"]), ("D", Var "E"), ("E", Comb "f" [Comb "f" [Comb "x" []]]), ("G", Var "H")]
subst4 = Subst [("A", Comb "g" [Comb "x" []]),("B", Comb "g" [Comb "x" []]),("C", Comb "g" [Comb "x" []]),("D", Comb "g" [Comb "x" []]),("H", Comb "false" [])]
composit2 = subst4 `compose` subst3

ds1 = Comb "." [Var "A", Comb "g" [Var "X", Var "_"] ,Var "h(A,B)",Var "D"]
ds2 = Comb "." [Var "A", Comb "g" [Var "X", Var "W"], Var "Z", Var "D"]

rule1 = (Rule (Comb "p" [Var "X", Var "Z"]) [(Comb "q" [Var "_", Var "Y"]), (Comb "p" [Var "Y", Var "Z"])])



goaltest  = Goal [(Comb "p" [Var "S", Comb "b" []])]
goaltest2 = Goal [(Comb "p" [Var "_", Comb "b" []])]
goaltest3  = Goal [(Comb "p" [Var "_", Var "S"])]
goaltest4  = Goal [(Comb "p" [Var "_0", Comb "b" []])]
goaltest5 = Goal [(Comb "p" [Var "_", Var "_"])]

progtest = Prog [ (Rule (Comb "p" [Var "X", Var "Z"]) [(Comb "q" [Var "X", Var "Y"]), (Comb "p" [Var "Y", Var "Z"])] ),
                  (Rule (Comb "p" [Var "X", Var "X"]) []),
                  (Rule (Comb "q" [Comb "a" [], Comb "b" []]) []) ]

dfstest  = intercalate ", " (map (pretty) (solve dfs progtest goaltest))
dfstest2 = intercalate ", " (map (pretty) (solve dfs progtest goaltest2))
dfstest3 = intercalate ", " (map (pretty) (solve dfs progtest goaltest3))
dfstest4 = intercalate ", " (map (pretty) (solve dfs progtest goaltest4))
dfstest5 = intercalate ", " (map (pretty) (solve dfs progtest goaltest5))





bfstest  = intercalate ", " (map (pretty) (solve bfs progtest goaltest))
bfstest2 = intercalate ", " (map (pretty) (solve bfs progtest goaltest2))


progtestsss   = (parseFile "append.pl") :: IO (Either String Prog)
goaltestsss2   = (parse "append(_,_,[1,2]).") :: Either String Goal
goaltestsss1   = (parse "append(X,Y,[1,2]).") :: Either String Goal


extractRule (Prog xs) = head xs

prog2323 = (parse "reverse([_0|_1], _2) :- reverse(_1, _3), append(_3, [_0], _2).") :: Either String Prog
ruletest = let rule = extractRule (fromRight' (Prog []) prog2323)
           in  pretty (rename ["_0","_1","_2"] rule)


appendtest = do x <- (parseFile "append.pl") :: IO (Either String Prog)
                let y = goaltestsss1
                let a = goaltestsss2
                let z = (intercalate ", " (map (pretty) (solve bfs (fromRight' (Prog []) x) (fromRight' (Goal []) y))))
                let b = (intercalate ", " (map (pretty) (solve bfs (fromRight' (Prog []) x) (fromRight' (Goal []) a))))
                let q = pretty (sld (fromRight' (Prog []) x) (fromRight' (Goal []) y))
                let p = pretty (sld (fromRight' (Prog []) x) (fromRight' (Goal []) a))
                putStrLn q
                putStrLn p


appendtest2 = do  x <- (parseFile "append.pl") :: IO (Either String Prog)
                  let y = goaltestsss1
                  let a = goaltestsss2
                  let z = (intercalate ", " (map (pretty) (solve bfs (fromRight' (Prog []) x) (fromRight' (Goal []) y))))
                  let b = (intercalate ", " (map (pretty) (solve bfs (fromRight' (Prog []) x) (fromRight' (Goal []) a))))
                  putStrLn z
                  putStrLn b


reverseprog = (parseFile "list.pl") :: IO (Either String Prog)

goalreverse = (parse "reverse([1,2,3],X).") :: Either String Goal

{--
( Goal reverse([1, 2, 3], X),  ( Subst und SLDT {X -> _2, _1 -> [2, 3], _0 -> 1}, 
( Goal reverse([2, 3], _3), append(_3, [1], _2),  ( Subst und SLDT {_5 -> 2, _4 -> [3], _3 -> 2}, 
( Goal reverse([3], _6), append(_6, [2], 2), append(2, [1], _2),  ( Subst und SLDT {_8 -> 3, _7 -> [], _6 -> 3}, 
( Goal reverse([], _9), append(_9, [3], 3), append(3, [2], 2), append(2, [1], _2),  ( Subst und SLDT {_9 -> []}, append([], [3], 3), append(3, [2], 2), append(2, [1], _2)))))))))


( Goal reverse([1, 2, 3], X),  ( Subst und SLDT {_0 -> 1, _1 -> [2, 3], X -> _2}, 
( Goal reverse([2, 3], _3), append(_3, [1], _2),  ( Subst und SLDT {_4 -> 2, _5 -> [3], _3 -> _6}, 
( Goal reverse([3], _7), append(_7, [2], _6), append(_6, [1], _2),  ( Subst und SLDT {_8 -> 3, _9 -> [], _7 -> _10}, 
( Goal reverse([], _11), append(_11, [3], _10), append(_10, [2], _6), append(_6, [1], _2),  ( Subst und SLDT {_11 -> []}, 
( Goal append([], [3], _10), append(_10, [2], _6), append(_6, [1], _2),  ( Subst und SLDT {_12 -> [3], _10 -> [3]}, 
( Goal append([3], [2], _6), append(_6, [1], _2),  ( Subst und SLDT {_13 -> 3, _14 -> [], _15 -> [2], _6 -> [3|_16]}, 
( Goal append([], [2], _16), append([3|_16], [1], _2),  ( Subst und SLDT {_17 -> [2], _16 -> [2]}, 
( Goal append([3, 2], [1], _2),  ( Subst und SLDT {_18 -> 3, _19 -> [2], _20 -> [1], _2 -> [3|_21]}, 
( Goal append([2], [1], _21),  ( Subst und SLDT {_22 -> 2, _23 -> [], _24 -> [1], _21 -> [2|_25]}, 
( Goal append([], [1], _25),  ( Subst und SLDT {_26 -> [1], _25 -> [1]}, ))))))))))))))))))))

--}


reversetest = do x <- reverseprog 
                 let a = pretty (sld (fromRight' (Prog []) x) (fromRight' (Goal []) goalreverse))
                 putStrLn a
                 


comb1 = (Comb "reverse" [ Comb "."[Comb "2" [], Comb "." [Comb "3" [], Comb "[]" []] ], Var "_3" ])
comb2 = (Comb "reverse" [ Comb "."[Var "_4", Var "_5"], Var "_6"] )
unifikation = fromJust (unify comb1 comb2)
applied1 = apply unifikation comb1
applied2 = apply unifikation comb2

occurs1 = Comb "f" [Var "X"]
occurs2 = Var "X"
occurstest = unify occurs1 occurs2


--appendprog = fromRight (Prog []) ((parseFile "append.pl") :: IO (Either String Prog))
