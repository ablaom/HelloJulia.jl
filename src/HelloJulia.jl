module HelloJulia

export go

using IJulia

const ROOT = joinpath(@__DIR__, "..")
const TUTORIALS = joinpath(ROOT, "tutorials")

go() = begin
    @show TUTORIALS
    notebook(dir=TUTORIALS)
end

end # module
