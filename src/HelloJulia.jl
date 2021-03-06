module HelloJulia

# should have form v"1.x" for some integer x:
const JULIA_VERSION = "1.7"
const ROOT = joinpath(@__DIR__, "..")
const NOTEBOOKS = joinpath(ROOT, "notebooks")

# need Pluto here?
import IJulia, PrecompilePlutoCourse, Pluto, Pkg
export go, start, pluto, setup, stop, jupyter, jupiter


go() = IJulia.notebook(dir=NOTEBOOKS)

const jupyter = go
const jupiter = go
const pluto = PrecompilePlutoCourse.start
const stop = PrecompilePlutoCourse.stop
const setup = PrecompilePlutoCourse.create_sysimage

function __init__()
    if haskey(ENV, "TEST_MLJBASE")
        ENV["TEST_MLJBASE"] = "false"
    end

    VERSION in Pkg.Types.VersionSpec(JULIA_VERSION) ||
        @warn "This version of HelloJulia.jl should be run "*
        "under Julia $(JULIA_VERSION.major).$(JULIA_VERSION.minor), "*
        "but you're running $VERSION. "

    PrecompilePlutoCourse.configure(
        @__MODULE__,
        start_notebook =
        joinpath(pkgdir(@__MODULE__), "notebooks", "pluto_index.jl"),
        warmup_file = joinpath(pkgdir(@__MODULE__), "precompile", "warmup.jl"),
        packages = [:Pluto, :HelloJulia, :CairoMakie, :Distributions]
    )
end

end # module
