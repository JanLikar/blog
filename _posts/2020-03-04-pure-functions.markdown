---
author: Jan Likar
layout: post
title:  "Why pure functions matter"
---

A (mathematically) pure function is a function that always returns the same output if called with the same parameters. Their return values depend on their parameters and their parameters only. Additionally, pure functions have no side-effects.

To put it differently, calling them does not affect the program's environment and their results do not change if their parameters don't change. They don't access the filesystem, they don't send out network packets, nor do they output CLI messages.

{% include title_image.html url="assets/working-pattern-internet-abstract-1089438.jpg" description="Image by Markus Spiske, acquired from https://www.pexels.com/photo/working-pattern-internet-abstract-1089438/" %}

Here's an example of a pure function in Python:

    def hypotenuse(a, b):
        return math.sqrt(a**2 + b**2)

But don't let this fool you; even much more complex, powerful functions can be pure.

Impure functions, among other things, include functions performing input/output operations, randomness generators, functions spawning threads or forking -- basically all non-deterministic functions.

While pure functions are mostly considered in the context of functional programming languages, this does not mean they aren't useful in languages that are more "traditional".

The majority of widely-used programming languages do not recognize the concept of a pure function. That doesn't mean pure functions are less useful in such languages. They are still extremely important for ensuring the correctness and maintainability of the codebase.

> Although practicality beats purity.

It is obvious we should strive to make our functions pure, whenever possible. 

No need to be dogmatic about it, though. Sometimes it just doesn't work.

## Advantages
1. They are easier to debug and reason about.
2. Some compilers and interpreters can differentiate pure functions from their counterparts and can apply optimizations to them. For instance, calls to pure functions can get replaced with constants, if the parameters are known at compile time.
3. They are often more reusable than impure functions.
4. It's easier to write tests and achieve high levels of test coverage because they reduce the need for mocking/stubbing.
5. Calls to pure functions that perform expensive computations can be memoized (cached).
6. Safe concurrency -- if you parallelize a pure function, there will be no data races, because they don't rely on the global state.

## Tips for maximizing the benefits of pure functions
### Localize side-effects
Haskell and similar languages naturally push us to structure our code in a way that separates side effects from pure computation. In conventional languages this must be practiced more deliberately.

A good advice I find myself returning to is to keep all operations with side-effects as close to the entry point of the program as possible. You would, for instance, open a file in the main part of the program (or close to it) and pass around its contents, rather than opening the file somewhere deep in the call stack. This might seem inefficient, but can be implemented without a huge performance impact by using lazy-loaded iterators, instead of reading the whole file into memory at once.

Try to put the majority of complex program logic into pure functions while keeping impure functions as simple as possible.

All of this will greatly simplify testing, as it will maximize the amount of code you can cover with simple unit tests and reduce the number of required integration tests.

Programs that achieve this are more transparent -- it is more evident how the program interacts with its environment.

### Test-driven approach
It is generally accepted test-driven development can in some cases be very beneficial to the practice of software development.

While I am not convinced tests should always be written before the actual code, I find it very beneficial to at least think about how the code will be tested before writing it. This tends to drive me towards having more pure functions.

### Make sure functions are really pure
In languages that don't have a type system that is able to differentiate between pure and impure functions, some degree of effort is required to ensure the functions are actually pure.

There can be no calls to non-pure functions, the code must not access immutable global variables, the functions should not have any internal state (think generators in Python), etc.

In certain programming languages, it can be hard to be 100% sure about the purity of a function. Some languages even perform impure operations, such as heap allocations, behind the developer's back, so no function can ever be considered strictly pure.

It is, however, still better to have an almost-pure function than a blatantly impure one.

### Take note of flaky unit tests
If a unit test in your test suite fails randomly, this is a good indicator that the underlying code is impure and depends on some should be refactored.
