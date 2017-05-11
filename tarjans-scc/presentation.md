% Tarjan's Strongly Connected Components Algorithm
% Vaibhav Sagar

# What is a strongly connected component

## Definition

- A subgraph is said to be strongly connected if every vertex is
  reachable from every other vertex.

##

![Source: Wikimedia](https://upload.wikimedia.org/wikipedia/commons/5/5c/Scc.png)

# The Algorithm

## Pseudocode

- [Wikipedia!](https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm#The_algorithm_in_pseudocode)

## Code

- [I did it in Haskell](https://github.com/vaibhavsagar/courses/blob/master/algorithms1/week4/SCC.ipynb)

## Linear Time!

## So why is this useful?

# Directed Acyclic Graphs

## Definition

-  A finite directed graph with no directed cycles.

##

![Source: Wikimedia](https://upload.wikimedia.org/wikipedia/commons/f/fe/Tred-G.svg)

##
![Source: Wikimedia](https://upload.wikimedia.org/wikipedia/commons/2/20/Graph_Condensation.svg)

# Git & Build Tools

## Git

- If I draw a commit graph, would it be a valid history?

## Build Tools

- Can the components of this project be built in the correct order?

# Topological sorting

## Definition

- A linear ordering of its vertices such that for every directed edge _uv_ from vertex _u_ to vertex _v_, _u_ comes before _v_ in the ordering.

##

![Source: Wikimedia](https://upload.wikimedia.org/wikipedia/commons/c/c6/Topological_Ordering.svg)

## Why Tarjan's SCC is awesome

- It computes the SCCs _and_ a reverse topological sort at the same time!

# 2SAT

## Definition

- Can a collection of boolean variables with constraints on pairs of variables be assigned values satisfying all the constraints?

## It's a graph problem

- `(u || v) == (not u => v) || (not v => u)`
- find the SCCs
- if a SCC contains _u_ and _not u_, it's unsatisfiable
- otherwise, topologically sort the results and use this to assign _T_ and _F_
  to the variables

## Code

- [I did it in Haskell](https://github.com/vaibhavsagar/courses/blob/master/algorithms2/week6/Week6.ipynb)
