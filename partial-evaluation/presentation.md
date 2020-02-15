% Compilers for nothing, executables for free!
% Vaibhav Sagar (@vbhvsgr)

# Partial Evaluation

## Programs take static and dynamic input

```
+--------+   +---------+
|        |   |         |
| Static |   | Dynamic |
|        |   |         |
+--------+   +---------+
     ^---+  +----^
         |  |
      +--+--+---+        +--------+
      |         |        |        |
      | Program +------->+ Output |
      |         |        |        |
      +---------+        +--------+
```

## Programs take static and dynamic input

- e.g. anything that has a configuration file
- such as... Vim!

## Can we pre-compute with static input?

- Feed the program and the static input into a program
- Simple transformations like inlining constants and unrolling loops

## "Residual" program

- Behaves the same as the original program but is faster

## Specialisers

```
+---------+    +--------+  +---------+
|         |    |        |  |         |
| Program |    | Static |  | Dynamic |
|         |    |        |  |         |
+---------+    +--------+  +---+-----+
     ^---+     +----^          ^
         |     |               |
         |     |               |
      +--+-----+----+      +---+------+   +--------+
      |             |      |          |   |        |
      | Specialiser +----->+ Residual +-->+ Output |
      |             |      |          |   |        |
      +-------------+      +----------+   +--------+
```

## Specialisers

- Specialise a program P "with respect to" input I

# Futamura projections

## Specialise interpreter with source program

```
+-------------+  +--------+  +-------+
|             |  |        |  |       |
| Interpreter |  | Source |  | Input |
|             |  |        |  |       |
+-------------+  +--------+  +---+---+
       ^---+     +----^          |
           |     |               |
           |     |               |
        +--+-----+----+      +---+-----+    +--------+
        |             |      |         |    |        |
        | Specialiser +----->+    ?    +--->+ Output |
        |             |      |         |    |        |
        +-------------+      +---------+    +--------+
```

## Specialise interpreter with source program

- Outputs a standalone program
- Faster than interpreter + source program
- We "compiled" it!

## Specialise specialiser with interpreter
```
+-------------+  +-------------+  +--------+
|             |  |             |  |        |
| Specialiser |  | Interpreter |  | Source |
|             |  |             |  |        |
+-------------+  +-------------+  +---+----+
       ^---+     +------^        +----^
           |     |               |
           |     |               |
        +--+-----+----+      +---+-----+    +------------+
        |             |      |         |    |            |
        | Specialiser +----->+    ?    +--->+ Executable |
        |             |      |         |    |            |
        +-------------+      +---------+    +------------+
```


## Specialise specialiser with interpreter

- Outputs a program that can then take a source program and output a standalone
  executable (like in step 1 above)
- We made a "compiler"!

## Specialise specialiser with specialiser

```
+-------------+  +-------------+  +-------------+
|             |  |             |  |             |
| Specialiser |  | Specialiser |  | Interpreter |
|             |  |             |  |             |
+-------------+  +-------------+  +-------------+
       ^---+     +------^        +-------^
           |     |               |
           |     |               |
        +--+-----+----+      +---+-----+    +----------+
        |             |      |         |    |          |
        | Specialiser +----->+    ?    +--->+ Compiler |
        |             |      |         |    |          |
        +-------------+      +---------+    +----------+
```

## Specialise specialiser with specialiser

- Outputs a program that can then take an interpreter and output a compiler
  (like in step 2)
- We made a "compiler compiler"!

# Why?

## Interpreter \<-\> Compiler?

- A specialiser sits somewhere between an interpreter and a compiler
- Small, simpler programs are easier to write and work with

## Optimisations

- Was what we did optimisation?
- Static Analysis, Loop Unrolling, Constant Inlining...

## PyPy, Truffle/Graal, LLVM

- Write your language a certain way and get a JIT for free!

## JIT

- Roughly the same as the second Futamura projection!

# Resources

# Thanks!
