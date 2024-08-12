% SATisfying Solutions to Difficult Problems!!
% Vaibhav Sagar (@vbhvsgr)

# SAT Solvers?

## NP-complete problems

- Decision (yes/no) problems
- Can be verified quickly (in polynomial time)
- Currently unknown how to solve quickly (P versus NP problem)
- All equivalent!

## Examples

- Knapsack
- Travelling salesman
- Subset sum
- Graph coloring
- Sudoku
- Boolean satisfiability

## Boolean Satisfiability Problem

Can we assign truth values to Boolean variables in propositional logic formulas
to satisfy the formula?

## Boolean Satisfiability Problem
- Commonly expressed like $(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg z)$ (CNF)
- NP-complete (!)
- Can express any other NP-complete problem!

## SAT Solvers

- Solve boolean satisfiability problems!
- Tell you satisfying assignments!!

# Sudoku

## Rules

- one number per cell
- each number once per row/column
- each number once per 3x3 sub-grid
- must respect existing values

## Insight

- 9 boolean variables for each cell!
- only 1/9 is true, rest are false
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

## Solving

1. Express your problem as a propositional logic formula in CNF
2. Feed it to a SAT solver
3. ????
4. PROFIT!!!

# DPLL

## Example

$$(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x) \wedge (\neg z)$$

x: `¯\_(ツ)_/¯`<br>
y: `¯\_(ツ)_/¯`<br>
z: `¯\_(ツ)_/¯`<br>

## Pick a variable

Let's set $z$ to False

## Unit propagation

- If there is a unary clause, assign it
- Delete all clauses that are satisfied
- Remove the literal where it is False

## Example

$$(x \vee y \xcancel{\vee z}) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x) \xcancel{\wedge (\neg z)}$$

x: `¯\_(ツ)_/¯`<br>
y: `¯\_(ツ)_/¯`<br>
z: `False`<br>

## Pick a variable

Let's set $y$ to True

## Example

$$\xcancel{(x \vee y \vee z) \wedge} (x \xcancel{\vee \neg y}) \wedge (\xcancel{\neg y \vee} \neg x) \xcancel{\wedge (\neg z)}$$

x: `¯\_(ツ)_/¯`<br>
y: `True`<br>
z: `False`<br>

## Conflict!

## Backtrack

Let's set $y$ to False

## Example

$$(x \xcancel{\vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg y \vee \neg x) \wedge (\neg z)}$$

x: `¯\_(ツ)_/¯`<br>
y: `False`<br>
z: `False`<br>

## Pure literal elimination

There is only one possible value for $x$, so assign it

## Solution

x: `True`<br>
y: `False`<br>
z: `False`<br>


## Davis-Putnam-Logemann-Loveland

- Backtracking search
- Unit propagation
- Pure literal elimination

## Downsides

- Often finds the same conflict multiple times
- Backtracks one level at a time (chronologically)
- No memory of past conflicts

## Can we do better?

# CDCL

## CDCL

- Distinguishes between decisions (assignments) and implications (unit
  propagation, literal elimination)
- Keeps track of the implication graph

## Example

$$\displaylines{(x_{1} \vee x_{4}) \wedge \\
(x_{1} \vee \neg x_{3} \vee \neg x_{8}) \wedge \\
(x_{1} \vee x_{8} \vee x_{12}) \wedge \\
(x_{2} \vee x_{11}) \wedge \\
(\neg x_{7} \vee \neg x_{3} \vee x_{9}) \wedge \\
(\neg x_{7} \vee x_{8} \vee \neg x_{9}) \wedge \\
(x_{7} \vee x_{8} \vee \neg x_{10}) \wedge \\
(x_{7} \vee x_{10} \vee \neg x_{12})}$$

## Decision Levels

<img src="images/tree1.svg" style="height: 10em;">

## Implication Graph

<img src="images/graph1.svg" style="height: 11em;">

## Unique Implication Point

<img src="images/graph2.svg" style="height: 11em;">

## Learned Clause

$$x_{8} \vee \neg x_{3} \vee \neg x_{7}$$

## Backjumping

<img src="images/tree2.svg" style="height: 10em;">

## Conflict-driven Clause Learning

- Learned clauses!
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
- Can be done in parallel
- Can use a form of CDCL
- Can't conclusively determine unsatisfiability(!)
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

We'd have to teach the SAT solver arithmetic!

## Satisfiability Modulo Theories

- SAT solvers extended
- Not limited to decision problems
- Z3, CVC, Yices, Boolector

# Recap

## SAT solvers

Solve NP-complete problems expressed as CNF Boolean formulas

## DPLL

- Backtracking search
- Unit propagation
- Pure literal elimination

## CDCL

- DPLL++
- Learned clauses
- Non-chronological backtracking

## SLS

- Random guessing
- Probabilistic variable flipping

## SMT solvers

SAT extended with theories

# Thank you!!

## Resources

- [Lindsey Kuper - Reasoning Under Uncertainty in SMT Solving, Research, and
  Life](https://www.youtube.com/watch?v=6K6HFl7UhQk)
- [The Science of Brute
  Force](https://cacm.acm.org/research/the-science-of-brute-force/)
- [Handbook of
  Satisfiability](https://www.iospress.com/catalog/books/handbook-of-satisfiability-2)
- [CS-E3220: Propositional satisfiability and SAT
  solvers](https://users.aalto.fi/~tjunttil/2020-DP-AUT/notes-sat/overview.html)

## Slides

[https://vaibhavsagar.com/presentations/sat-solvers](https://vaibhavsagar.com/presentations/sat-solvers)
