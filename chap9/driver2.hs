import Parser (parse)
import Lexer (alexScanTokens, prettyToken)
import Semant
import Env
import FindEscape
import qualified Canon as C
import DalvikFrame as Frame

main = do
  s <- getContents
  let tokens = alexScanTokens s
  let ast = parse tokens
  let (ast', _, _) = findEscape ast
  let (ty, frgs, t) = transProg base_venv base_tenv ast'
  let (stm:stms) = fmap Frame.get_body frgs
  -- TODO: not only stm but (stm:stms) should be linearized.
  let (stms1, t1) = C.linearize stm t
  print frgs
  print stms1
  
