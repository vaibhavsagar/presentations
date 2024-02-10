% The Real Hash Was the Friends We Made along the Way
% Vaibhav Sagar (@vbhvsgr)

# Minimal Perfect Hashing

## FOSSASIA 2018

<iframe width="560" height="315" src="https://www.youtube.com/embed/8Zu-EVjN24s" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Minimal Perfect Hashing?

- Minimal
- Perfect
- Hashing

## Hashing

function that takes a key to a fixed size value (often an integer)

## Perfect Hashing

hashing without collisions (injective)


## *Minimal* Perfect Hashing

- all possible keys are known in advance
- perfect hashing without gaps
- bijective mapping from $n$ keys to $1..n$

## Pros

- usually more space-efficient than most other approaches
- (especially if you are using this to create a hashtable)

## Cons

- upfront construction cost
- static
- produces nonsense results for absent keys

## tl;dr

- if you're not sure you need this, you probably don't

# Approaches

## Not Discussed Today

- Hash, Displace, and Compress (CHD)
- Hypergraph peeling?

## Also Not Discussed Today

```haskell
minimalPerfectHash keys = Map.fromList $ zip keys [0..]
```

## Discussed Today

- Fast and scalable minimal perfect hashing for massive key sets
- [https://arxiv.org/abs/1702.03154](https://arxiv.org/abs/1702.03154)

# How does it work?


## Cascading Collisionless Bitarrays

<img src="images/cascading-collisionless-arrays.svg" style="height: 11em;">

## Requirements

- Family of hash functions
- Bitvectors supporting rank (and select)

## Family of hash functions?

- My understanding is that hash functions that take a salt should work
- Suspiciously similar to Bloom filters

## Bitvectors supporting rank and select?

- $rank(i)$ is the number of $1$s at or prior to index $i$ (1-indexed)
- $select(i)$ is the index $n$ where the $i$th 1 is located (1-indexed)
- Look up "succinct data structures" for more fun with these

## Bitvectors supporting rank and select?

<img src="images/support-rank-select.png" style="height: 8em;">

# How it works

## High level

1. Until we've reached max level or there are no more keys:
    1. Turn the key into a number $i ∈ [0..n)$
    1. Inspect $bitvector[i]$:
        1. if $0$ and no collision: $bitvector[i] = 1$
        1. if $1$: $bitvector[i] = 0$ and record collision
        1. if $0$ and collision: do nothing
    1. Remove non-colliding keys
1. If there are leftover keys, put them in a hashtable

## Turning the key into a number

```haskell
-- gamma is a multiplier for the size of the bitvector
value = hashWithSalt currentLevel key `mod` (gamma * currentLength)
```

## Populating the bitvector

1. Initialise two bitvectors $B$ and $C$ with $0$s
1. When setting an index $i$:
    1. If $B[i] \equiv 0$ and $C[i] \equiv 0$ then $B[i] = 1$
    1. If $B[i] \equiv 1$ then $B[i] = 0$ and $C[i] = 1$
    1. If $B[i] \equiv 0$ and $C[i] \equiv 1$ then do nothing

## Lookup

1. For each level:
    1. Hash the key and check if the corresponding index is set
    1. If so, find the rank
    1. If not, increment the level count and repeat
1. Otherwise check the leftovers

# Example

## Keys

- Bondi
- Tamarama
- Bronte
- Clovelly
- Gordons Bay
- Coogee

## Level 0

```
┌─┐
│0│ <- ["Clovelly","Bronte"]
├─┤
│1│ <- ["Gordons Bay"]
├─┤
│0│
├─┤
│0│
├─┤
│0│ <- ["Coogee","Tamarama"]
├─┤
│1│ <- ["Bondi"]
└─┘
```

## Level 1

```
┌─┐
│0│
├─┤
│0│
├─┤
│0│
├─┤
│0│ <- ["Coogee","Clovelly","Bronte","Tamarama"]
└─┘
```

## Level 2

```
┌─┐
│0│ <- ["Coogee","Clovelly","Bronte","Tamarama"]
├─┤
│0│
├─┤
│0│
├─┤
│0│
└─┘
```

## Level 3

```
┌─┐
│0│
├─┤
│0│ <- ["Coogee","Clovelly","Bronte","Tamarama"]
├─┤
│0│
├─┤
│0│
└─┘
```

## Level 4

```
┌─┐
│0│
├─┤
│0│
├─┤
│0│ <- ["Coogee","Clovelly","Bronte","Tamarama"]
├─┤
│0│
└─┘
```

## ...

- I went ahead and ran this for 20 more levels and the keys kept colliding
- No slack in our bitvectors
- Let's try with `gamma = 1.5`

## Level 0

```
┌─┐
│1│ <- ["Bronte"]
├─┤
│1│ <- ["Gordons Bay"]
├─┤
│0│
├─┤
│0│
├─┤
│0│ <- ["Coogee","Tamarama"]
├─┤
│0│
├─┤
│1│ <- ["Clovelly"]
├─┤
│0│
├─┤
│1│ <- ["Bondi"]
└─┘
```

## Level 1

```
┌─┐
│0│ <- ["Coogee","Tamarama"]
├─┤
│0│
├─┤
│0│
└─┘
```


## Level 2

```
┌─┐
│1│ <- ["Tamarama"]
├─┤
│1│ <- ["Coogee"]
├─┤
│0│
└─┘
```

## Lookup

```default
 0 1 2 3 4 5 6 7 8
┌─┬─┬─┬─┬─┬─┬─┬─┬─┐
│1│1│0│0│0│0│1│0│1│ b0
└─┴─┴─┴─┴─┴─┴─┴─┴─┘
┌─┬─┬─┐
│0│0│0│ b1
└─┴─┴─┘
┌─┬─┬─┐
│1│1│0│ b2
└─┴─┴─┘
```

```haskell
> hashWithSalt 0 "Coogee" `mod` 9
4
> hashWithSalt 1 "Coogee" `mod` 3
0
> hashWithSalt 2 "Coogee" `mod` 3
1
> popCount b0 + popCount b1 + rank b2 1
6
```

## Minimal Perfect Hash Table

1. Create a $values$ vector
2. $values[hash(key)] = value$
3. ???
4. PROFIT!!!

# Here's some code

## Further reading

- [Throw away the keys: Easy, Minimal Perfect Hashing](http://stevehanov.ca/blog/?id=119)
- [Compress, Hash and Displace: CHD Algorithm](https://cmph.sourceforge.net/chd.html)

# Questions?

# Thank You!

## These slides

[https://vaibhavsagar.com/presentations/minimal-perfect-hashing/](https://vaibhavsagar.com/presentations/minimal-perfect-hashing/)
