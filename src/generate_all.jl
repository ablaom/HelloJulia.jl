const NOTEBOOK_PATHS = [
    "mandelbrot",
    "pkg_composability",
    "secret_sauce",
    "01_first_steps",
    "02_dataframes",
    "03_machine_learning",
    "99_solutions_to_exercises"
]

for path in NOTEBOOK_PATHS
    include(joinpath(@__DIR__, "..", "notebooks", path, "generate.jl"))
end
