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

## Tarjan's Algorithm

## What's an SCC?

## Topological sort

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
