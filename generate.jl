# helper
function runcommand(cmd)
    @info cmd
    run(cmd)
end

# `env` is the environment directory 
function generate(env)
    quote
        using Pkg
        Pkg.activate(temp=true)
        Pkg.add(name="Literate", rev="fe/pluto")
        using Literate

        const ENVDIR = $env
        const OUTDIR = joinpath(ENVDIR, "..")
        const INFILE = joinpath(OUTDIR, "notebook.jl")

        # generate pluto notebook:
        Literate.notebook(INFILE, ENVDIR, flavor=Literate.PlutoFlavor())
        runcommand(`mv $ENVDIR/notebook.jl $OUTDIR/notebook.pluto.jl`)

        Literate.notebook(INFILE, OUTDIR, execute=false)
        runcommand(
            `mv $OUTDIR/notebook.ipynb $OUTDIR/notebook.unexecuted.ipynb`)
        Literate.notebook(INFILE, OUTDIR, execute=true)

    end |> eval
end

# Pkg.add("Pluto")
# using Pluto
# Pluto.run(notebook=joinpath(OUTDIR, "notebook.pluto.jl"))

# Pkg.add("IJulia")
# Pkg.instantiate()
# using IJulia
# IJulia.notebook(dir=OUTDIR)
