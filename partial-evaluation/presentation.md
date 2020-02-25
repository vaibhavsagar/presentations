% Compilers for nothing, executables for free!
% Vaibhav Sagar (@vbhvsgr)

# Problem

## Vim

- I have a `.vimrc`
- Vim could be faster
- Extra functionality that I don't need

## My Special Vim

- Inline my `.vimrc` into the Vim source code
- Throw away anything else that isn't needed
- Smaller and faster!

# Partial Evaluation

## Programs take static and dynamic input

```
+--------+   +---------+
|        |   |         |
| Static |   | Dynamic |
|        |   |         |
+----+---+   +---+-----+
     \---+   +---/
         |   |
         v   v
      +--+---+--+        +--------+
      |         |        |        |
      | Program +------->+ Output |
      |         |        |        |
      +---------+        +--------+
```

## Programs take static and dynamic input

- e.g. anything that has a configuration file

## Can we pre-compute with static input?

- Feed the program and the static input into a program
- Simple transformations like inlining constants and unrolling loops

## Inlining

```python
tab_width = 4
# ...
for i in range(tab_width):
    insert_space()
```

## Inlining

```python
for i in range(4):
    insert_space()
```

## Unrolling

```python
for i in range(4):
    insert_space()
```

## Unrolling

```python
insert_space()
insert_space()
insert_space()
insert_space()
```

## "Residual" program

- Behaves the same as the original program but is faster

## Specialisers

```
+---------+    +--------+  +---------+
|         |    |        |  |         |
| Program |    | Static |  | Dynamic |
|         |    |        |  |         |
+----+----+    +----+---+  +---+-----+
     \---+     +----/          |
         |     |               |
         v     v               v
      +--+-----+----+      +---+------+   +--------+
      |             |      |          |   |        |
      | Specialiser +----->+ Residual +-->+ Output |
      |             |      |          |   |        |
      +-------------+      +----------+   +--------+
```

## Specialisers

- Specialise a program P "with respect to" input I

# Interpreters vs. Compilers

## Interpreters

- E.g. Python
- Execute instructions directly
- Simpler to write
- Slow

## Compilers

- E.g. C
- Generate standalone programs
- Harder to write
- Fast

## Can we have both?

- Simple to write
- Fast enough

# Futamura projections


## Specialise interpreter with source program

```
+-------------+  +--------+  +-------+
|             |  |        |  |       |
| Interpreter |  | Source |  | Input |
|             |  |        |  |       |
+------+------+  +---+----+  +---+---+
       \---+     +---/           |
           |     |               |
           v     v               v
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
+------+------+  +------+------+  +---+----+
       \---+     +------/        +----/
           |     |               |
           v     v               v
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
+------+------+  +------+------+  +------+------+
       \---+     +------/        +-------/
           |     |               |
           v     v               v
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

## Faster programs

- i.e. the specialised Vim of my dreams!

# Thanks!

## Resources

- [The Wikipedia page](https://en.wikipedia.org/wiki/Partial_evaluation)
- [Yoshihiko Futamura's seminal *Partial Computation of Programs*](https://repository.kulib.kyoto-u.ac.jp/dspace/handle/2433/103401)
- [Tom Stuart's *Compilers for Free*](https://codon.com/compilers-for-free)
- [A free online textbook](https://www.itu.dk/people/sestoft/pebook/)
- [Darius Bacon's *A Hacker's Intro to Partial Evaluation*](http://wry.me/~darius/writings/peval/)
- [*Is There a Fourth Futamura Projection?*](https://www.gwern.net/docs/cs/2009-gluck.pdf)

## Futamura!

<img src=images/futamura-logo.png>

# Bonus: The Fourth Futamura Projection

## Fixed point

```
+-------------+  +-------------+  +-------------+
|             |  |             |  |             |
| Specialiser |  | Specialiser |  | Specialiser |
|             |  |             |  |             |
+------+------+  +------+------+  +------+------+
       \---+     +------/        +-------/
           |     |               |
           v     v               v
        +--+-----+----+      +---+-----+    +--------------+
        |             |      |         |    |              |
        | Specialiser +----->+    ?    +--->+ Specialiser! |
        |             |      |         |    |              |
        +-------------+      +---------+    +--------------+
```
