# Launching the live tutorial

- *Installing julia compiler:*
  [Ubuntu](https://ferrolho.github.io/blog/2019-01-26/how-to-install-julia-on-ubun)
  or similar; [Mac, Windows, or
  other](https://julialang.org/download/). This tutorial has been
  tested on Julia 1.6.
    
- Open the downloaded application (or run `julia` from a
  terminal/console) to launch the command-line interface for
  interacting with julia (its called the
  [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop)).

- Type the following at the `julia>` prompt:

```julia
using Pkg
Pkg.add(url="https://github.com/ablaom/HelloJulia.jl")

using HelloJulia
go()
```


### For more experienced users

Clone this repository locally and navigate to the appropriate sub-folder of
`/tutorials`. Open the file with `.jl` extension in your Julia-enabled
IDE.

---

[![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) 

