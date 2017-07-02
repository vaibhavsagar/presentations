% Lazy Functional State Threads
% Vaibhav Sagar

# What

## Strict stateful computation in Haskell

## Why

![Source: Three Word Phrase](http://www.threewordphrase.com/pardonme.gif)

## But seriously

- Union find
- Hashtables
- Performance

# Overview

## State Transformers

```
                                        Result
               +---------------------+    ^
               |                     |    |
               |                     +----+
               |                     |
               |                     |
      +------->+                     +-------->
 State in      +---------------------+  State out
```

## Multiple inputs/outputs

```
Inputs                                   Results
 +   +       +---------------------+     ^   ^
 |   |       |                     |     |   |
 |   +------>+                     +-----+   |
 +---------->+                     +---------+
             |                     |
 +-----------+                     +--------->
   State in  +---------------------+  State out
```

## returnST

```haskell
--                                     Result
--   +        +---------------------+    ^
--   |        |                     |    |
--   +------->---------------------------+
--            |                     |
--            |                     |
--   +------->------------------------------->
--  State in  +---------------------+  State out
returnST :: a -> ST s a
```

## thenST

```haskell
--             +----------------------------------------+  Result
--             |                                        |    ^
--             |  +-------------+     +-------------+   |    |
--             |  |            ------>+             +--------+
--             |  |     s1      |     |     s2      |   |
--  +------------>+            ------>+             +-------->
--   State in  |  +-------------+     +-------------+   |   State out
--             |                                        |
--             +----------------------------------------+
thenST :: ST s a -> (a -> ST s b) -> ST s b
```

## A pattern emerges

```haskell
class Monad m where
    return ::   a -> m a
    (>>=)  :: m a -> (a -> m b) -> m b
```

## thenST\_

```haskell
thenST_ :: ST s () -> ST s b -> ST s b
(>>) :: Monad m => m a -> m b -> m b
(>>) a b = a >>= (\_ -> b)
```

## seqST

```haskell
seqST :: [ST s ()] -> ST s ()
sequence_ :: Monad m => [m a] -> m ()
```

# References

## API

```haskell
newVar   :: a -> ST s (MutVar s a)
readVar  :: MutVar s a -> ST s a
writeVar :: MutVar s a -> a -> ST s ()
```


## Example

```haskell
swap :: MutVar s a -> MutVar s a -> ST s ()
swap v w = do
    a <- readVar v
    b <- readVar w
    writeVar v b
    writeVar w a
```

# Encapsulation

## An incorrect implementation

```haskell
runST :: ST s a -> a
```

## A broken program

```haskell
let v = runST (newVar True)
in
runST (readVar v)
```

## A correct implementation

```haskell
runST :: ∀a. (∀s. ST s a) -> a
```

# Array references

## API

```haskell
newArr    :: Ix i => (i, i) -> elt -> ST s (MutArr s i elt)
readArr   :: Ix i => MutArr s i elt -> i -> ST s elt
writeArr  :: Ix i => MutArr s i elt -> i -> elt -> ST s ()
freezeArr :: Ix i => MutArr s i elt -> ST s (Array i elt)
```

## Example

```haskell
accumArray :: Ix i => (a -> b -> a) -> a -> (i, i) -> [(i, b)] -> Array i a
accumArray f z bnds ivs = runST $ do
    a <- newArr bnds z
    seqST (map (update a f) ivs)
    freezeArr s

update a f (i, v) = do
    x <- readArr a i
    writeArr a i (f x v)

hist :: Ix i => (i, i) -> [i] -> Array i Int
hist bnds is = accumArray (+) 0 bnds [(i, 1) | i <- is, inRange bnds i]

binSort :: Ix i => (i,i) -> (a -> i) -> [a] -> Array i a
binSort bnds key vs = accumArray (flip (:)) [] bnds [(key v, v) | v <- vs]
```

# Input/output

## API

```haskell
type IO a = ST RealWorld a
```

## Example

```haskell
putChar :: Char -> IO ()
getChar :: IO Char

putString cs = seqST (map putChar cs)
```

## ccall

- A builtin that allows the programmer to interface with C

## ccall

```haskell
putChar c = do
    ccall putChar c
    return ()
getChar = ccall getChar
```

## mainIO

- Plays the same role as `main()` in C

# Implementation

## Update in place

- State is single-threaded
- State is strict
- In-place updates are fine

## Efficiency

```haskell
type ST s a = State s -> (a, State s)

instance Monad (ST s) where

return  x s = (x, s)
m (>>=) k s = k x s' where (x, s') = m s

fixST k s = (r, s') where (r, s') = k r s
runST m = r where (r, s) = m currentState
```

## Transformation

```haskell
do
    v1 <- m1
    v2 <- m2
    return e
```

## Transformation

```haskell
\s -> let (v1, s1) = m1 s
          (v2, s2) = m2 s1
      in (e, s3)
```

## Transformation

```haskell
\s -> case m1 s of
        (v1, s1) -> case m2 s1 of
                      (v2, s2) -> (e, s2)
```

## Passing the state around

```haskell
data State s = MkState (State# s)

newVar init (MkState s#)
  = case newVar# init s# of
        (v, t#) -> (v, MkState t#)
```

## freezeArray

- Can be optimised if we know no further mutations are performed

## IO

```haskell
m (>>=) k s = case m s of
                (r, s') -> k r s'
```

## Equality

```haskell
eqMutVar :: MutVar s a -> MutVar s a -> Bool
eqMutArr :: Ix i => MutArr s i a -> MutArr s i a -> Bool
```

## Interleaved and parallel operations

```haskell
interleaveST :: ST s a -> ST s a

readFile :: String -> IO [Char]
readFile filename = do
    f <- openFile filename
    readCts f

readCts :: FileDescriptor -> IO [Char]
readCts f = interleaveST $ do
    c <- readCh f
    if c == eofChar
        then return []
        else do
            cs <- readCts f
            return (c:cs)
```

# Conclusion

## Have we turned Haskell into C?

## Eating your cake and having it too

# Questions?
