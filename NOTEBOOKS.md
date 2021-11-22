Notebooks for demos in the workshop (and some others) can be run by
following the following instructions:

- [Install the Julia compiler](FIRST_STEPS.md)

- **In a new Julia session** type the following at the `julia>` prompt:

```julia
using Pkg
Pkg.develop(url="https://github.com/ablaom/HelloJulia.jl")
Pkg.activate(joinpath(Pkg.devdir(), "HelloJulia"))
Pkg.instantiate()

using HelloJulia
go()
```


### To run as script in your editor (for more experienced users)

Clone this repository locally and navigate to the appropriate sub-folder of
`/notebooks`. Open the file with `.jl` extension in your Julia-enabled
IDE.

---

[![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) 

