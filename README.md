# HelloJulia.jl


Tutorials for a workshop introducing Julia and machine learning in Julia.

UNDER CONSTRUCTION

| Linux | Coverage |
| :------------ | :------- |
| [![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) | [![Coverage](https://codecov.io/gh/ablaom/HelloJulia.jl/branch/master/graph/badge.svg)](https://codecov.io/github/ablaom/HelloJulia.jl?branch=master) |

To run the tutorials provided in this repository:

### Beginner instructions

- If necessary, install [Julia 1.6](https://julialang.org/download/)
  on your machine.

- To start the so-called REPL, open (click on) the Julia 1.6
  application. This should run Julia in a command-line environment
  specific to your operating system (e.g., unix shell) so that your
  see a `julia >` prompt..

- Type the following at the `julia>` prompt:

```julia
using Pkg
Pkg.add(url="https://github.com/ablaom/HelloJulia.jl")

using HelloJulia
go()
```

- This should launch a Juptyer notebook session in your browser. Now
  choose one of the folders in the list, say "lightning_tour", and
  from the directory that opens, select the file with the `.ipynb`
  extension (such as `lightning_tour.ipynb`).
  
**Having technical difficulties?** You can inspect static versions of
a notebook by navigating to the appropriate file with extension `.md`
(e.g., `lightning_tour.md`) starting
[here](https://github.com/ablaom/HelloJulia.jl/tree/dev/tutorials/).

### For more experienced users

Clone this repository locally and navigate to the appropriate sub-folder of
`/tutorials`. Open the file with `.jl` extension in your Julia-enabled
IDE.

