% Moving towards dialogue
% Collaborating with your computer using typed holes!
% Vaibhav Sagar (@vbhvsgr)

# Let's write a program

## I write programs for a living

## I am a terrible programmer

## A simple function in Python

```python
>>> def map(f, ls): [f(e) for e in ls]
...
>>> plusOne = lambda i: i + 1
>>> print(map(plusOne, [1, 2, 3]))
None
```

## A simple function in Python

```python
>>> def map(f, ls): return (f(e) for e in ls)
...
>>> print(map(plusOne, [1, 2, 3]))
<generator object map.<locals>.<genexpr> at 0x7ffb92103ca8>
```

## A simple function in Python

```python
>>> def map(f, ls): return []
```

## How do I write a program that works?

## "Just be smarter!"

<img src="https://media.giphy.com/media/Fml0fgAxVx1eM/giphy.gif"></img>

## Write tests!

Actually useful advice!

## Write tests!

```python
>>> def map(f, ls):
...     print("Where are your tests now?")
...     return [2, 3, 4]
...
>>> map(plusOne, [1, 2, 3]) == [2, 3, 4]
Where are your tests now?
True
```

## Write tests!

<img src="https://media.giphy.com/media/t02k4SiBnDoTS/giphy.gif"></img>

## Tests are a specification that the language does not understand

## Types are a specification that the language can understand

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
- [Conor McBride - What are Types for, or are they only Against?](https://www.youtube.com/watch?v=3U3lV5VPmOU)
- [Conor McBride - Is a type a lifebuoy or a lamp?](https://skillsmatter.com/skillscasts/8893-is-a-type-a-lifebuoy-or-a-lamp)

# Thank You
