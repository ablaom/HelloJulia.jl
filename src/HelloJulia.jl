module HelloJulia

# should have form "1.x" for some integer x; do not use v"1.x".
const JULIA_VERSION = "1.8"
const ROOT = joinpath(@__DIR__, "..")
const NOTEBOOKS = joinpath(ROOT, "notebooks")

# need Pluto here?
import IJulia, PrecompilePlutoCourse, Pluto, Pkg
export go, start, pluto, pluto_now, setup, stop, jupyter, jupiter

const START_NOTEBOOK = joinpath(pkgdir(@__MODULE__), "notebooks", "pluto_index.jl")

go() = IJulia.notebook(dir=NOTEBOOKS)
const jupyter = go
const jupiter = go

const pluto = PrecompilePlutoCourse.start
const stop = PrecompilePlutoCourse.stop
function setup()
    Pkg.build("Conda")
    Pkg.build("IJulia")
    PrecompilePlutoCourse.create_sysimage
end

function __init__()
    if haskey(ENV, "TEST_MLJBASE")
        ENV["TEST_MLJBASE"] = "false"
    end

    VERSION in Pkg.Types.VersionSpec(JULIA_VERSION) ||
        @warn "This version of HelloJulia.jl should be run "*
        "under Julia $JULIA_VERSION"
        "but you're running $VERSION"

    PrecompilePlutoCourse.configure(
        @__MODULE__;
        start_notebook = START_NOTEBOOK,
        warmup_file = joinpath(pkgdir(@__MODULE__), "precompile", "warmup.jl"),
        packages = [:Pluto, :HelloJulia, :CairoMakie, :Distributions]
    )
end

pluto_now() = Pluto.run(notebook=START_NOTEBOOK)

end # module
