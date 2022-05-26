const NOTEBOOKS = [
    ("Fractals using Julia",
     joinpath("mandelbrot", "notebook.pluto.jl")),
    ("Basic demonstration of Julia package composability",
     joinpath("pkg_composability", "notebook.pluto.jl")),
    # ("Brief sketch of Julia's secret sauce",
    #  joinpath("secret_sauce", "notebook.pluto.jl")),
    ("Tutorial 1. Crash course in Julia basics",
     joinpath("01_first_steps", "notebook.pluto.jl")),
    ("Tutorial 2. An introduction to data frames",
     joinpath("02_dataframes", "notebook.pluto.jl")),
    ("Solutions to exercises",
     joinpath("99_solutions_to_exercises", "notebook.pluto.jl")),
]

function _linkname(path, nb, basedir)
    if haskey(ENV, "html_export") && ENV["html_export"] == "true"
        joinpath(basedir, "$(splitext(nb)[1]).html")
    else
        "open?path=" * joinpath(path, nb)
    end
end
function list_notebooks(file, basedir = "")
    sp = splitpath(file)
    path = joinpath(@__DIR__, "..", "notebooks")
    filename = split(sp[end], "#")[1]
    list = join(["- " * (nb == filename ?
                            name * " (this notebook)" :
                            "[$name](" * _linkname(path, nb, basedir) * ")")
                 for (name, nb) in NOTEBOOKS], "\n")
    Markdown.parse("""# Hello Julia!

                   $list

                   """)
end

function footer()
    html"""
        <hr>
        <style>
            #launch_binder {
                display: none;
            }
        </style>
        <p> Resources provided as part of  <a href="https://github.com/ablaom/HelloJulia.jl">HelloJulia.jl</a>
    """
end
