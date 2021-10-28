# execute this file to generate the files ../tutorial.pluto.jl and
# ../tutorial.ipynb from tutorial.jl

using Pkg
Pkg.activate(temp=true)
Pkg.add(name="Literate", rev="fe/pluto")
using Literate
DIR = @__DIR__
const OUTDIR = joinpath(DIR, "..")
const INFILE = joinpath(DIR, "tutorial.jl")
Literate.notebook(INFILE, OUTDIR, flavor=Literate.PlutoFlavor())
`mv $OUTDIR/tutorial.jl $OUTDIR/tutorial.pluto.jl` |> run
Literate.notebook(INFILE, OUTDIR, execute=true)

# Pkg.add("Pluto")
# using Pluto
# Pluto.run(notebook=joinpath(OUTDIR, "tutorial.pluto.jl"))

# Pkg.add("IJulia")
# Pkg.instantiate()
# using IJulia
# IJulia.notebook(dir=OUTDIR)
