import Prelude hiding (map)

map :: (a -> b) -> [a] -> [b]
map f ls = undefined

plusOne :: Int -> Int
plusOne i = i + 1

main :: IO ()
main = print (map plusOne [1,2,3])
