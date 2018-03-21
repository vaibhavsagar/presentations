data Vect : Nat -> Type -> Type where
  Nil  : Vect Z a
  (::) : a -> Vect k a -> Vect (S k) a

displayVect : Show a => Vect k a -> String
displayVect [] = "[]"
displayVect (x :: y) = "[" ++ show x ++ go y ++ "]"
  where
    go : Vect k a -> String
    go [] = ""
    go (x :: xs) = ", " ++ show x ++ go xs

map : (a -> b) -> Vect k a -> Vect k b

plusOne : Int -> Int
plusOne i = i + 1

main : IO ()
main = putStrLn (displayVect (map plusOne [1,2,3]))
