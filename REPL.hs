import Data.List

import SLD
import Substitution
import Type
import Unifikation
import Vars

import System.Console.ANSI

-- Prog = Loaded program, Strategy = SLD tree traversal strategy
data REPLState = REPLState Prog Strategy

repl :: IO ()
repl = do
  setSGR [SetColor Background Vivid Blue]
  putStrLn "Welcome!\nType \":h\" for help."
  setSGR [Reset]
  putStrLn "Testest"
  repl' (REPLState (Prog []) dfs)

repl' :: REPLState -> IO ()
repl' st = do
  putStr "-? "
  userInput <- getLine
  evalUserInput userInput st

helpMsg :: String
helpMsg = "Commands available from the prompt:" ++
          "\n  <goal>      Solves/proves the specified goal." ++
          "\n  :h          Shows this help message." ++
          "\n  :l <file>   Loads the specified file." ++
          "\n  :q          Exits the interactive environment." ++
          "\n  :s <strat>  Sets the specified search strategy" ++
          "\n              where <strat> is either 'dfs' or 'bfs'."

cmdNotFoundMsg :: String
cmdNotFoundMsg = "Command not found! Type :h for help."

loadProg progFile = Prog []

selectStrat _ = dfs
evalGoal _ = do putStrLn "Goal."

evalUserInput :: String -> REPLState -> IO ()
evalUserInput userInput (REPLState prog strat) = do
  case (take 2 userInput) of
    ":h" -> do putStrLn helpMsg
               repl' (REPLState prog strat)
    ":q" -> return ()
    _    -> if isPrefixOf ":l" userInput
               then repl' (REPLState (loadProg (drop 3 userInput)) strat)
            else if isPrefixOf ":s" userInput
               then repl' (REPLState prog (selectStrat (drop 3 userInput)))
            else if isPrefixOf ":" userInput
                then do putStrLn cmdNotFoundMsg
                        repl' (REPLState prog strat)
            else do evalGoal userInput
                    repl' (REPLState prog strat)
