% Minimal Perfect Hashing
% Vaibhav Sagar (@vbhvsgr)

# Minimal Perfect Hashing

## FOSSASIA 2018

<iframe width="560" height="315" src="https://www.youtube.com/embed/8Zu-EVjN24s" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Minimal Perfect Hashing?

- Minimal
- Perfect
- Hashing

## Hashing

- function that takes a key to a fixed size value (often an integer)

## Perfect Hashing

- hashing without collisions (injective)

## Minimal Perfect Hashing

- perfect hashing without gaps
- bijective mapping from $n$ keys to $1..n$
- downsides: static, produces nonsense results for absent keys

# Approaches

## Not Discussed Today

- Hash, Displace, and Compress (CHD)
- Hypergraph peeling?

## Discussed Today

- Fast and scalable minimal perfect hashing for massive key sets
- [https://arxiv.org/abs/1702.03154](https://arxiv.org/abs/1702.03154)

# How does it work?


## Helpful Diagram

<img src="images/cascading-collisionless-arrays.svg" style="height: 11em;">

## Requirements

- Family of hash functions
- Bitvectors supporting rank and select

## Family of hash functions?

- My understanding is that hash functions that take a salt should work

## Bitvectors supporting rank and select?

- Rank(i) is the number of $1$s at or prior to index $i$ (1-indexed)
- Select(i) is the index $n$ where the $i$th 1 is located (1-indexed)
- Fun phrase to google: "succinct data structures"

## Bitvectors supporting rank and select?

<img src="images/support-rank-select.png" style="height: 8em;">

# How it works

## High level

1. Repeat the following until we've reached max level or there are no more keys
    1. Turn the key into a number $0..n-1$ where $n$ is the length of the bitvector
    1. Set the $i$th bit of the bitvector if unset, otherwise unset it and never set it again this iteration
    1. Remove the keys whose corresponding bits were set
1. If there are leftovers, put them in a hashtable


# Example

## Keys

- Bras Basah
- Bugis
- Outram
- Paya Lebar
- River Valley
- Tanjong Pagar
