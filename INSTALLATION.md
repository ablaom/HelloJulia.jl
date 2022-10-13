# Demos and Tutorials

For a quick static view of the demo and tutorial notebooks, click on a
link in the first column.

To run a notebook without installing anything, click on the binder
link. These notebooks are ephemeral, and can be very slow to load, and
are therefore not recommended for in-depth study. Rather, complete
[Setup](#setup) and choose one of the options that follow.


Juptyer | binder
--------|---------
[Mandelbrot set demo](notebooks/mandelbrot/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fmandelbrot%2Fnotebook.ipynb)
[Julia's secret sauce](notebooks/secret_sauce/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fsecret_sauce%2Fnotebook.ipynb)
[Package composability](notebooks/pkg_composability/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fpkg_composability%2Fnotebook.ipynb)
[01 - First_steps](notebooks/01_first_steps/notebook.unexecuted.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F01_first_steps%2Fnotebook.unexecuted.ipynb)
[02 - DataFrames](notebooks/02_dataframes/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F02_dataframes%2Fnotebook.ipynb)
[03 - Machine learning](notebooks/03_machine_learning/notebook.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F03_machine_learning%2Fnotebook.ipynb)

## Setup

- [Install a correct version of the Julia compiler](FIRST_STEPS.md).

- **In a new Julia session** type the following at the `julia>` prompt:

```julia
ENV["JULIA_PKG_PRECOMPILE_AUTO"]=0
using Pkg
Pkg.activate(temp=true)
Pkg.develop(url="https://github.com/ablaom/HelloJulia.jl")
Pkg.activate(joinpath(Pkg.devdir(), "HelloJulia"))
Pkg.instantiate()
ENV["JULIA_PKG_PRECOMPILE_AUTO"]=1

using HelloJulia

```

## Option 1: To run as Jupyter notebooks

- Enter `go()` at the `julia>` prompt

- In the browser window that should appear, navigate to the folder of
interest

- Choose the file called `notebook.unexecuted.ipynb` (or
  `notebook.ipynb` to see pre-executed version)


## Option 2: To run as Pluto notebooks

- When running for the first time, enter (immediately after
  [Setup](#setup)):

```julia
julia> setup()
```

ignoring any "ld: warning" you get. This will take several minutes but
speeds up using the notebooks. (It creates a Julia system image
tailored to the notebook content.)

- Quit Julia with `control-D` and restart.

- Run the following commands each time you want to run the notebooks:

```julia
using Pkg; Pkg.activate(joinpath(Pkg.devdir(), "HelloJulia"))
using HelloJulia
pluto()
```

If you encounter problems with running `setup()` or `pluto()` you can try launching the notebooks directly (without creating a system image) by restarting Julia and trying:

```julia
using Pkg; Pkg.activate(joinpath(Pkg.devdir(), "HelloJulia"))
using HelloJulia
pluto_now()
```

The only difference here is that notebooks may take a while to load, at least the first
time they are launched.


## Option 3: To run as script in your editor

For more experienced users and instructors.

Clone this repository locally and navigate to the appropriate
sub-folder of `/notebooks`. Open the file `notebook.jl` in your
Julia-enabled IDE.

---

[![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) 
