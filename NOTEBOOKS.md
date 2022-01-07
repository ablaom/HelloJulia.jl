# Demos and Tutorials

We recommend that tutorials and demos in the workshop be run by
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

Navigate to the folder of interest and choose the file called
`notebook.unexecuted.ipynb`.


### To run as script in your editor (for more experienced users)

Clone this repository locally and navigate to the appropriate sub-folder of
`/notebooks`. Open the file with `.jl` extension in your Julia-enabled
IDE.


### Static and Binder versions

The binder versions are live Jupyter notebooks not requiring Julia
installation, but can be slow to load.

- [secret_sauce](notebooks/secret_sauce/notebook.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fsecret_sauce%2Fnotebook.ipynb)

- [pkg_composability](notebooks/pkg_composability/notebook.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fpkg_composability%2Fnotebook.ipynb)

- [01_first_steps](notebooks/01_first_steps/notebook.unexecuted.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2F01_first_steps%2Fnotebook.unexectued.ipynb)

- [02_data_frames](notebooks/02_data_frames/notebook.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fdata_frames%2Fnotebook.ipynb)

- [mandelbrot](notebooks/mandelbrot/notebook.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ablaom/HelloJulia.jl/dev?labpath=notebooks%2Fmandel_brot%2Fnotebook.ipynb)


### Live versions not requiring installation

These can be slow to load.


---

[![Build Status](https://github.com/ablaom/HelloJulia.jl/workflows/CI/badge.svg)](https://github.com/ablaom/HelloJulia.jl/actions) 
