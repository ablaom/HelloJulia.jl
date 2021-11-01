module HelloJulia

export go

using IJulia

const ROOT = joinpath(@__DIR__, "..")
const NOTEBOOKS = joinpath(ROOT, "notebooks")

go() = begin
    notebook(dir=NOTEBOOKS)
end

end # module
