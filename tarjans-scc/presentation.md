% Now You're Cooking with DAGs!
% Vaibhav Sagar
% @vbhvsgr

# Drawing a Git repository

# All Git commit graphs are DAGs

## Here's a DAG

<img src="images/dag.svg">

## Here's a not-DAG

<img src="images/notdag.svg">

# What I need

## Determinining DAGness

## Highlighting not-DAG bits

## Processing vertices in some order

# How???

## StackOverflow search

<img src=images/question.png>

*Source: https://stackoverflow.com/questions/583876/how-do-i-check-if-a-directed-graph-is-acyclic*

## Topological sort

<img src=images/toposort.png>

*Source: https://stackoverflow.com/questions/583876/how-do-i-check-if-a-directed-graph-is-acyclic*

## Topological sort

<img src="https://upload.wikimedia.org/wikipedia/commons/c/c6/Topological_Ordering.svg" style="height: 9em;">

*Source: https://upload.wikimedia.org/wikipedia/commons/c/c6/Topological_Ordering.svg*

## SCCs

<img src=images/tarjansccalgo.png>

*Source: https://stackoverflow.com/questions/583876/how-do-i-check-if-a-directed-graph-is-acyclic*

## SCCs

<img src="https://upload.wikimedia.org/wikipedia/commons/5/5c/Scc.png">

*Source: https://upload.wikimedia.org/wikipedia/commons/5/5c/Scc.png*

## Tarjan's Algorithm

```default
 algorithm tarjan is
  input: graph G = (V, E)
  output: set of strongly connected components (sets of vertices)

  index := 0
  S := empty array
  for each v in V do
    if (v.index is undefined) then
      strongconnect(v)
    end if
  end for

  function strongconnect(v)
    // Set the depth index for v to the smallest unused index
    v.index := index
    v.lowlink := index
    index := index + 1
    S.push(v)
    v.onStack := true

    // Consider successors of v
    for each (v, w) in E do
      if (w.index is undefined) then
        // Successor w has not yet been visited; recurse on it
        strongconnect(w)
        v.lowlink  := min(v.lowlink, w.lowlink)
      else if (w.onStack) then
        // Successor w is in stack S and hence in the current SCC
        // If w is not on stack, then (v, w) is a cross-edge in the DFS tree and must be ignored
        // Note: The next line may look odd - but is correct.
        // It says w.index not w.lowlink; that is deliberate and from the original paper
        v.lowlink  := min(v.lowlink, w.index)
      end if
    end for

    // If v is a root node, pop the stack and generate an SCC
    if (v.lowlink = v.index) then
      start a new strongly connected component
      repeat
        w := S.pop()
        w.onStack := false
        add w to current strongly connected component
      while (w != v)
      output the current strongly connected component
    end if
  end function
```

## (Reverse) topological sort

## Linear time!

# Demonstration

##

<img src="images/0.svg" style="height: 9em;">

##

<img src="images/1.svg" style="height: 9em;">

- stack: []
- output: []

##

<img src="images/2.svg" style="height: 9em;">

- stack: [ 1 ]
- output: []

##

<img src="images/3.svg" style="height: 9em;">

- stack: [ 2, 1 ]
- output: []

##

<img src="images/4.svg" style="height: 9em;">

- stack: [ 3, 2, 1 ]
- output: []

##

<img src="images/5.svg" style="height: 9em;">

- stack: [ 3, 2, 1 ]
- output: []

##

<img src="images/6.svg" style="height: 9em;">

- stack: [ 3, 2, 1 ]
- output: []

##

<img src="images/7.svg" style="height: 9em;">

- stack: [ 3, 2, 1 ]
- output: []

##

<img src="images/8.svg" style="height: 9em;">

- stack: []
- output: [ [3, 2, 1] ]

##

<img src="images/9.svg" style="height: 9em;">

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/10.svg" style="height: 9em;">

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/11.svg" style="height: 9em;">

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/12.svg" style="height: 9em;">

- stack: [ 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/13.svg" style="height: 9em;">

- stack: [ 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/14.svg" style="height: 9em;">

- stack: [ 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/15.svg" style="height: 9em;">

- stack: [ 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/16.svg" style="height: 9em;">

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/17.svg" style="height: 9em;">

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/18.svg" style="height: 9em;">

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/19.svg" style="height: 9em;">

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src="images/20.svg" style="height: 9em;">

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src="images/21.svg" style="height: 9em;">

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src="images/22.svg" style="height: 9em;">

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src="images/23.svg" style="height: 9em;">

- stack: []
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src="images/24.svg" style="height: 9em;">

- stack: [ 8 ]
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src="images/25.svg" style="height: 9em;">

- stack: [ 8 ]
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src="images/26.svg" style="height: 9em;">

- stack: []
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ], [ 8 ] ]

# Applications

## Build tools

## Dataflow processing

## Dataflow processing

<img src=images/tensorflowscc.png>

## 2-SAT

# Takeaways

## Reverse topological sort

## Strongly connected components

## Tarjan's Algorithm

# Thanks!
