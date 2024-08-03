% SATisfying Solutions to Difficult Problems!!
% Vaibhav Sagar (@vbhvsgr)

# SAT Solvers?

## NP-complete problems

- Decision (yes/no) problems whose solutions can be verified in polynomial time
- All equivalent!

## NP-complete problems

- Knapsack problem
- Travelling salesman problem
- Subset sum problem
- Graph coloring problem
- Sudoku

## Boolean Satisfiability Problem

- Problems of the form $(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg z)$ (CNF)
- NP-complete (!)
- Can express any other NP-complete problem!

## SAT Solvers

Programs that can solve boolean satisfiability problems!

# Sudoku

## Rules

- one number per cell
- each number once per row
- each number once per column
- each number once per 3x3 sub-grid
- must respect existing values

## Insight

- 9 boolean variables for each cell!
- $x_{r,c,1}$, $x_{r,c,2}$,...,$x_{r,c,9}$

## Each cell has at least one value

$$(x_{1,1,1} \vee x_{1,1,2} \vee \dots \vee x_{1,1,9}) \wedge$$
$$(x_{1,2,1} \vee x_{1,2,2} \vee \dots \vee x_{1,2,9}) \wedge$$
$$ \dots $$
$$(x_{9,9,1} \vee x_{9,9,2} \vee \dots \vee x_{9,9,9})$$

## Each row has all values

$$(x_{1,1,1} \vee x_{1,2,1} \vee \dots \vee x_{1,9,1}) \wedge$$
$$(x_{1,1,2} \vee x_{1,2,2} \vee \dots \vee x_{1,9,9}) \wedge$$
$$ \dots $$
$$(x_{9,1,9} \vee x_{9,2,9} \vee \dots \vee x_{9,9,9})$$

## Each cell has at most one value

$$(\neg x_{1,1,1} \vee \neg x_{1,1,2}) \wedge$$
$$(\neg x_{1,1,1} \vee \neg x_{1,1,3}) \wedge$$
$$ \dots $$
$$(\neg x_{9,9,8} \vee \neg x_{9,9,9})$$

# DPLL

## Example

$$(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x) \wedge (\neg z)$$

```default
x: ¯\_(ツ)_/¯
y: ¯\_(ツ)_/¯
z: ¯\_(ツ)_/¯
```

## Pick a variable

Let's set $z$ to False

## Unit propagation

- If there is a unary clause, assign it
- Delete all clauses that are satisfied
- Remove the literal where it is False

## Example

$$(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x) \wedge (\neg z)$$

becomes

$$(x \vee y) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x)$$

```default
x: ¯\_(ツ)_/¯
y: ¯\_(ツ)_/¯
z: False
```

## Pick a variable

Let's set $y$ to True

## Example

$$(x \vee y) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x)$$

becomes

$$(x) \wedge (\neg x)$$

```default
x: ¯\_(ツ)_/¯
y: True
z: False
```

## Conflict!

## Backtrack

Let's set $y$ to False

## Example

$$(x \vee y) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x)$$
becomes
$$(x)$$

```default
x: ¯\_(ツ)_/¯
y: True
z: False
```

## Pure literal elimination

- There is only one possible value for $x$

## Solution

```default
x: True
y: True
z: False
```

## Davis-Putnam-Logemann-Loveland

- Backtracking search
- Unit propagation
- Pure literal elimination

## Downsides

- Potentially finds the same conflict multiple times
- Backtracks one level at a time (chronologically)
- No memory of past conflicts

## Can we do better?

# CDCL

## CDCL

- Distinguishes between decisions and consequences
- Keeps track of the implication graph

## Example

## Conflict-driven Clause Learning

- Non-chronological backtracking!
- Basis of most modern SAT solvers

## Okay Now Let's Do A Silly One

# SLS

## What if we just guessed?

1. Generate a random assignment
2. Pick a random clause
3. Probabilistically flip a variable in the clause
4. Repeat until you solve it or get tired!

## Stochastic Local Search

- Surprisingly effective!
- WalkSAT
- Reminds me of simulated annealing in some ways

# SMT

## Problem

```default
  SEND
+ MORE
------
 MONEY
```

## How?

- We'd have to teach the SAT solver arithmetic!

## Satisfiability Modulo Theories

- SAT solvers extended
- Not limited to decision problems
- Z3, CVC, Yices, Boolector

# Recap

## SAT solvers

- NP-complete problems expressed as CNF Boolean formulas

## DPLL

- Backtracking search
- Unit propagation
- Pure literal elimination

## CDCL

- DPLL
- Learned clauses
- Non-chronological backtracking

## SLS

- Random guess
- Probabilistic variable flipping

## SMT solvers

- SAT extended with theories

# Thank you!!