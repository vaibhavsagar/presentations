% SATisfying Solutions to Difficult Problems!!
% Vaibhav Sagar (@vbhvsgr)

# SAT Solvers?

## Boolean Satisfiability Problem

- Problems of the form $(x \vee y \vee z) \wedge (x \vee \neg y) \wedge (\neg z)$ (CNF)
- NP-complete (!)
- Can express any other NP-complete problem!

## NP-complete problems

- Knapsack problem
- Travelling salesman problem
- Subset sum problem
- Graph coloring problem
- Sudoku (!)

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

```python
for r in range(1,10):
    for c in range(1, 10):
	add_clause(or(x[r][c][n] for n in range(1,10)))
```

## Each row has all values

```python
for r in range(1,10):
    for n in range(1,10):
        add_clause(or(x[r][c][n] for c in range(1,10)))
```

## Each cell has at most one value

```python
for r in range(1,10):
    for c in range(1,10):
        for i in range(1,10):
            for j in range(i,10):
                add_clause(or([not(x[r][c][i]), not(x[r][c][j])]))
```

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

## DPLL

- Backtracking search
- Unit propagation
- Pure literal elimination

## Can we do better?

# CDCL

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
