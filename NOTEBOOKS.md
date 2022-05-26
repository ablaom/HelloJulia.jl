# Demos and Tutorials

We recommend that tutorials and demos in the workshop be run by
following the following instructions. 

## Setup

- [Install the Julia compiler](FIRST_STEPS.md)

- **In a new Julia session** type the following at the `julia>` prompt:

```julia
using Pkg
Pkg.activate(temp=true)
Pkg.develop(https://github.com/jbrea/PrecompilePlutoCourse.jl)
Pkg.develop(url="https://github.com/ablaom/HelloJulia.jl")
Pkg.activate(joinpath(Pkg.devdir(), "HelloJulia"))
Pkg.instantiate()

using HelloJulia
```

## Option 1: To run as Jupyter notebooks

- Enter `go()` at the `julia>` prompt

- In the browser window that should appear, navigate to the folder of
interest 

- Choose the file called `notebook.unexecuted.ipynb` (or
  `notebook.ipynb` to see pre-executed version)


### Option 2: To run as Pluto notebooks

- When running for the first time, enter

```julia
julia> setup()
```

This will take several minutes but speeds up using the notebooks. (It
creates a Julia system image tailored to the tutorial content.)

- Quit Julia with `control-D` and restart.

- Enter `pluto()` at the `julia>`  prompt.


### Option 3: Static and Binder versions

The binder versions are live Jupyter notebooks not requiring Julia
installation, but may be slow to load.

Juptyer | binder
--------|---------
[Mandelbrot set demo](notebooks/mandelbrot/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fmandelbrot%2Fnotebook.ipynb)
[Julia's secret sauce](notebooks/secret_sauce/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fsecret_sauce%2Fnotebook.ipynb)
[Package composability](notebooks/pkg_composability/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fpkg_composability%2Fnotebook.ipynb)
[01 - First_steps](notebooks/01_first_steps/notebook.unexecuted.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F01_first_steps%2Fnotebook.unexecuted.ipynb)
[02 - Data Frames](notebooks/02_dataframes/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F02_dataframes%2Fnotebook.ipynb)


### Option 4: To run as script in your editor

For more experienced users and instructors.

Clone this repository locally and navigate to the appropriate
sub-folder of `/notebooks`. Open the file `notebook.jl` in your
Julia-enabled IDE.
---

[![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) 
