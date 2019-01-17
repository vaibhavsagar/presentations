% Now You're Cooking with DAGs!
% Vaibhav Sagar

# Drawing a Git repository

# All Git commit graphs are DAGs

## Here's a DAG

## Here's a not-DAG

# What I need

## Determinining DAGness

## Highlighting not-DAG bits

## Processing vertices in some order

# How???

## StackOverflow search

## What's an SCC?

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

<img src=demo/0.svg>

##

<img src=demo/1.svg>

- stack: []
- output: []

##

<img src=demo/2.svg>

- stack: [ 1 ]
- output: []

##

<img src=demo/3.svg>

- stack: [ 2, 1 ]
- output: []

##

<img src=demo/4.svg>

- stack: [ 3, 2, 1 ]
- output: []

##

<img src=demo/5.svg>

- stack: [ 3, 2, 1 ]
- output: []

##

<img src=demo/6.svg>

- stack: [ 3, 2, 1 ]
- output: []

##

<img src=demo/7.svg>

- stack: [ 3, 2, 1 ]
- output: []

##

<img src=demo/8.svg>

- stack: []
- output: [ [3, 2, 1] ]

##

<img src=demo/9.svg>

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/10.svg>

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/11.svg>

- stack: [ 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/12.svg>

- stack: [ 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/13.svg>

- stack: [ 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/14.svg>

- stack: [ 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/15.svg>

- stack: [ 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/16.svg>

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/17.svg>

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/18.svg>

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/19.svg>

- stack: [ 7, 6, 5, 4 ]
- output: [ [3, 2, 1] ]

##

<img src=demo/20.svg>

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src=demo/21.svg>

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src=demo/22.svg>

- stack: [ 5, 4 ]
- output: [ [3, 2, 1], [ 7, 6 ] ]

##

<img src=demo/23.svg>

- stack: []
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src=demo/24.svg>

- stack: [ 8 ]
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src=demo/25.svg>

- stack: [ 8 ]
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ] ]

##

<img src=demo/26.svg>

- stack: []
- output: [ [3, 2, 1], [ 7, 6 ], [ 5, 4 ], [ 8 ] ]

# Applications

## Build tools

## Dataflow processing (Tensorflow)

## 2-SAT

# Takeaways

## Reverse topological sort

## Strongly connected components

## Tarjan's Algorithm

# Thanks!
