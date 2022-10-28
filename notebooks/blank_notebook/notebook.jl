# The following block makes some third party packages available for loading, and ensurese
# the *same* versions are loaded every time. Beginners do not need to understand it.

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()
