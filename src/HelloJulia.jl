module HelloJulia

export go, start, pluto

using IJulia, PrecompilePlutoCourse, Pluto

const ROOT = joinpath(@__DIR__, "..")
const NOTEBOOKS = joinpath(ROOT, "notebooks")

go() = begin
    notebook(dir=NOTEBOOKS)
end

pluto() = start()

function __init__()
    PrecompilePlutoCourse.configure(
        @__MODULE__,
        start_notebook =
        pkgdir(@__MODULE__, "notebooks","mandelbrot", "notebook.pluto.jl"),
        warmup_file = pkgdir(@__MODULE__, "precompile", "warmup.jl"),
        packages = [:Pluto, :HelloJulia, :CairoMakie]
    )
end

end # module

