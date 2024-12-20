data Vect : Nat -> Type -> Type where
    Nil  : Vect 0 a
    (::) : a -> Vect length a -> Vect (1 + length) a

implementation (Eq a) => Eq (Vect l a) where
    (==) []      []      = True
    (==) (x::xs) (y::ys) = x == y && xs == ys









map : (a -> b) -> Vect length a -> Vect length b








plusOne : Int -> Int
plusOne i = i + 1

main : IO ()
main = printLn ((map plusOne [1, 2, 3]) == [2, 3, 4])
