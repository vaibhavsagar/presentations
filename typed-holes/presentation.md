% Moving towards dialogue
% Collaborating with your computer using typed holes!
% Vaibhav Sagar (@vbhvsgr)

# What's a typed hole?

## Typed holes

A placeholder for an expression with a known type and an unknown value.

## Why?

They allow the programming language to help us write programs!

# Why do holes need to be typed?

## Let's write a program in Python

<style>
code.sourceCode.python {
  font-size: 150%;
  line-height: 125%;
}
</style>

## Is this program correct?

```python
>>> def map(f, ls): return []
```

## Is this program correct?

```python
>>> def map(f, ls): [f(e) for e in ls]
...
>>> plusOne = lambda i: i + 1
>>> print(map(plusOne, [1, 2, 3]))
None
```

## Is this program correct?

```python
>>> def map(f, ls): return (f(e) for e in ls)
...
>>> print(map(plusOne, [1, 2, 3]))
<generator object map.<locals>.<genexpr> at 0x7ffb92103ca8>
```

## How do I write programs that work?

## We need tests!

```python
>>> def map(f, ls):
...     print("Where are your tests now?")
...     return [2, 3, 4]
...
>>> map(plusOne, [1, 2, 3]) == [2, 3, 4]
Where are your tests now?
True
```

## Tests are not sufficient

## The language does not understand tests

## The language can understand types

# Haskell

## Statically typed!
## Type inference!
## Typed holes!

# Idris

## More sophisticated type system!
## Weaker type inference :(
## Better editor integration!
## Fancier typed holes!

# We did it!

## Typed holes exist!!!
## Types are friends, not food!
## Programming can be fun and interesting!

## Resources

- [Typed Holes for beginners](https://www.shimweasel.com/2015/02/17/typed-holes-for-beginners)
- [Conor McBride - What Are Types For, Or Are They Only Against?](https://www.youtube.com/watch?v=3U3lV5VPmOU)
- [Conor McBride - Is a type a lifebuoy or a lamp?](https://skillsmatter.com/skillscasts/8893-is-a-type-a-lifebuoy-or-a-lamp)

# Thank You

# Untyped Holes: Program Sketching!

## 1. Write a program with gaps (a 'sketch')

## 2. Write some test cases

## 3. Give a SAT/SMT solver your sketch and test cases

## 4. ???

## 5. Profit!

## Still a research topic for now :'(

## Resources

- [Armando Solar-Lezama - Program Synthesis by Sketching](https://people.csail.mit.edu/asolar/papers/thesis.pdf)
- [Synquid](http://comcom.csail.mit.edu/comcom/#Synquid)
