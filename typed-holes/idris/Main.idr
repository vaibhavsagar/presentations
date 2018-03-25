data Vect : Nat -> Type -> Type where
  Nil  : Vect Z a
  (::) : a -> Vect k a -> Vect (S k) a

implementation (Eq a) => Eq (Vect l a) where
  (==) []      []      = True
  (==) (x::xs) (y::ys) = x == y && xs == ys

map : (a -> b) -> Vect k a -> Vect k b

plusOne : Int -> Int
plusOne i = i + 1

main : IO ()
main = print (map plusOne [1, 2, 3] == [2, 3, 4])
