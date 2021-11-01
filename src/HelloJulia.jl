module HelloJulia

export go

using IJulia

const ROOT = joinpath(@__DIR__, "..")

go() = begin
    @show TUTORIALS
    notebook(dir=TUTORIALS)
end

end # module
