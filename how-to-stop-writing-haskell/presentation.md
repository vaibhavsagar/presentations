% How to stop writing Haskell
% Vaibhav Sagar (@vbhvsgr)

# Why would you want to stop writing Haskell?

## Great question!

- Haskell is pretty great!
- Companies seem to stop writing Haskell surprisingly often!
- Why does this keep happening?

## A personal experience

- Started looking for my first Haskell job nearly a decade ago
- Failed initially, but got an ops job at an e-commerce company after many
  months
- Famously the birthplace of a popular Haskell HTTP API DSL
- Last Haskell dev left a month before my start date
- Why would you want to stop writing Haskell??

## About this talk

- I will do my best to avoid naming names
- About Haskell-the-ecosystem rather than Haskell-the-language
- My perspective on the absurdity of the tech industry
- An especially strange time

# Some facts about Haskell

## Haskell is not mainstream

- Few domains where Haskell is the "safe" choice
- Nobody Ever Got Fired for Picking Java
- If your Haskell project fails, it's Haskell's fault

## Haskell is not mainstream

<img src="images/how-could-haskell-do-this.jpg" style="height: 12em;">

## Haskell is not trendy (anymore)

- Other, newer, languages: Rust, Lean, TypeScript, etc.
- Stuck in a weird place

## Haskell avoids "success at all costs"

- Very sensitive to any one entity exercising undue influence
- Hard to imagine an equivalent to e.g. Jane Street for OCaml
- Competing tools/philosophies, e.g. `lens` vs. `optics`

# Some facts about companies

## Companies seek to maximise profit

- Specifically shareholder value
- Often incompatible with personal/professional development, highest quality
  product, and other desirable outcomes
- Worse is better

## Most companies seek to maximise short-term profit

- Sometimes at the expense of long-term profit
- "The market can remain irrational longer than you can remain solvent" - Keynes

## Companies undervalue maintenance

- Constant pressure to "do more with less"
- Nobody ever gets credit for fixing problems that never happened
- Firefighting is more visible and more likely to be rewarded

## Companies undervalue maintenance

<img src="images/drowning-high-five.webp" style="height: 12em;">

# Why start using Haskell?

## Political influence + desire to write Haskell = $$$
- Believing that Haskell is a good fit for your problem
- Trying to hire skilled programmers
- Trying to retain a key employee
- Getting people to work on something boring

# Taxonomy

## A non-exhaustive list
- The Second System
- The Second System Pt. II
- The Experiment
- The Vanity Project
- The Giant Client
- The Acquisition
- The Insolvency
- The Ousting
- The Magpie
- The Rocket Explosion
- The Outgrowing

# Let's begin!

# The Second System

## The situation

- Company decides to rewrite a non-Haskell codebase in Haskell
- Implied (or explicit) outcome is that the existing team will lose their jobs

## The problem

- Adversarial relationship with current team
- Toxic work environment
- Existing codebase provides business value so you have to work on it
- Second-system effect

## Second-system effect
<img src="images/secondsystem.png" style="height: 12em;">

## Suggestions

- Ask yourself why a rewrite is happening
- Many successful Haskell adoptions look like sidecars
- Threatening someone's livelihood is not a good way to get them on your side
- They probably don't want to learn a new language
- If you suspect you're being set up to fail, you know what to do
- Explore your options! (This will come up a lot)

# The Second System Pt. II

## The situation

- Company decides to rewrite a Haskell codebase in a non-Haskell language
- Implied (or explicit) outcome is that the existing Haskell team will lose
  their jobs
- Some might leave after the decision anyway

## The problem

- All the problems I mentioned before
- Working Haskell product is on life support
- Maintaining it is not a fun job (because maintenance is undervalued!)

## Suggestions

- Don't panic!
- These projects usually take longer than expected, even if you take this into
  account
- Explore your options!

# The Experiment

## The situation

- Funding (often fixed-term) to solve a problem with Haskell
- Eventually runs out

## The problem

- Software projects and tight deadlines don't mix
- Haskell is blamed for the failure
- The problem with venture capital is that you eventually run out of other
  people's money

## Suggestions

- Ride the gravy train till the end?
- Figure out an exit plan while things are still good

# The Vanity Project

## The situation

- Somebody starts a Haskell project as a way of enriching their personal brand

## The problem

- Questionable commitment to Haskell itself or the project
- Increasingly bizarre requests for features

## Suggestions

- Ride the gravy train until the end?
- Use the opportunity for personal/professional development
- Try not to leave a smoking crater behind

# The Giant Client

## The situation

- Company ostensibly has multiple clients, in practice only one
- Client ends its contract

## The problem

- Niche client pool
- Buyer's market

## Suggestions

- Try very hard to avoid this situation
- Exit plan!

# The Acquisition

## The situation

<img src="images/stonks.png" style="height: 12em;">

## The situation

- Company is acquired by another, larger, company
- Often an acqui-hire rather than a product acquisition

## The problem

- Acquiring company has no commitment to Haskell
- One less Haskell company

## Suggestions

- Stay just long enough for your stock to vest?
- Exit plan!

# The Insolvency

## The situation

- Company runs out of money

## The problem

- Company runs out of money

## Suggestions

- That's rough, buddy (this happened to me recently)
- You tell me?

# The Ousting

## The situation

- Influential person leaves the company
- Their political capital was enabling the use of Haskell

## The problem

- Replacement wants to "shake things up" which usually involves getting rid of
  Haskell
- see: Second System Pt. II

## Suggestions

- This rarely happens immediately
- Exit plan!

# The Magpie

## The situation

- Company picked Haskell because it was trendy at the time but has pivoted to
  e.g. Rust

## The problem

- Second System Pt. II
- No commitment to Haskell but also no commitment to the replacement language

## Suggestions

- Ask the difficult questions about why technology choices are made

# The Rocket Explosion

## The situation

- Haskell codebase is too complicated

## The problem

- Abstraction ceiling in Haskell is enormously high
- Still delivering business value though
- Second System effect means the replacement could be worse!

## Suggestions

- Collectively agree on which subset of Haskell you are using

# The Outgrowing

## The situation

- Company grows large enough that they have extremely specific requirements of
  the Haskell ecosystem

## The problem

- Companies are reluctant to fund this development work or do it themselves
- "Avoid success at all costs" means the ecosystem isn't going to do what you
  want just because you want it

## Suggestions

- Put your money where your mouth is
- Most large non-Haskell companies have teams dedicated to developer tooling
  for other languages, why not us?

# Recap

## A non-exhaustive list (again)
- The Second System
- The Second System Pt. II
- The Experiment
- The Vanity Project
- The Giant Client
- The Acquisition
- The Insolvency
- The Ousting
- The Magpie
- The Rocket Explosion
- The Outgrowing

## Rarely Haskell-specific!

<img src="images/how-could-haskell-do-this.jpg" style="height: 12em;">

# What to do?

## Take care of yourself first

- Your greatest leverage as an individual is your ability to walk away
- Emergency fund
- Your reputation outlives any job you will have

## Collective action is pretty great

<img src="images/monkey-stronger-together.png" style="height: 12em;">

## Failure is not the end

- That API DSL is very much alive and in use
- Personal and professional development
- Hope springs eternal

# Thank you!

# Questions
