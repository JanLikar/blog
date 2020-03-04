---
layout: post
title:  "Benefits of pure functions"
---
A (mathematically) pure function is a function that always returns the same output if called with the same parameters. Their return values depend on their parameters and their parameters only.

To put it differently, pure functions have no side-effects. At the same time, calling them does not affect the program's environment. They don't access the filesystem, they don't send out network packets, nor do they output CLI messages.

Here's an example of a pure function in Python:

    def hypotenuse(a, b):
        return a**2 + b**2

But don't let this fool you; even much more complex, powerful functions can be pure.

While pure functions are mostly considered in the context of functional programming languages, this does not mean they aren't useful in languages that are more "traditional".

The majority of widely-used programming languages do not recognize the concept of a pure function. That doesn't mean pure functions are less useful in such languages. They are still extremely important for ensuring the correctness and maintainability of the codebase.

> Although practicality beats purity.

It is obvious we should strive to make our functions pure, whenever possible. 

No need to be dogmatic about it, though. Sometimes it just doesn't work.

## Advantages
1. Some compilers and interpreters can differentiate pure functions from their counterparts and can apply optimizations to them. For instance, calls to pure functions can get replaced with constants, if the parameters are known at compile time.
2. They are easier to debug and reason about. 
3. It's easier to write tests and achieve high levels of test coverage because they reduce the need for mocking/stubbing.
4. Calls to pure functions that perform expensive computations can be memoized (cached).
5. Safe concurrency -- if you parallelize a pure function, there will be no data races, because they don't rely on the global state.
6. They are often more reusable than impure functions.

## Tips for maximizing the benefits of pure functions
### Localize side-effects
Haskell and similar languages naturally push us to structure our code like this, while in conventional languages it must be practiced more deliberately.

Keep all operations with side-effects as close to the entry point of the program as possible. Programs that achieve this are more transparent -- it is more evident how the program interacts with its environment.

Try to put the majority of complex program logic into pure functions while keeping impure functions as simple as possible.

This will greatly simplify testing, as it will maximize the amount of code you can cover with simple unit tests and reduce the number of required integration tests.

### Test-driven approach
While I am not convinced tests should always be written before the actual code, I find it very beneficial to at least think about how the code will be tested before writing it. This tends to drive me towards having more pure functions.

### Make sure functions are really pure
In languages that don't have a type system that is able to differentiate between pure and impure functions, some degree of effort is required to ensure the functions are actually pure.

There can be no calls to non-pure functions, the code must not access immutable global variables, the functions should not have any internal state (think generators in Python), etc.

In certain programming languages, it can be hard to be 100% sure about the purity of a function, but it's still better to have an almost-pure function than a blatantly impure one.

### Take note of flaky unit tests
If a unit test in your test suite fails randomly, this is a good indicator that the underlying code is impure and should be refactored. 

