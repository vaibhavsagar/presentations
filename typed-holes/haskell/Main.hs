import Prelude hiding (map)

map :: (a -> b) -> [a] -> [b]
map f ls = _

main :: IO ()
main = print (map (+1) [1,2,3])
