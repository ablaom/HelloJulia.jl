const WARMUP_PLUTO_NOTEBOOK = joinpath(
    @__DIR__,
    "..",
    "notebooks",
    "01_first_steps",
    "notebook.pluto.jl"
)

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Pluto
using MLJ
import BetaML
using DataFrames
using CairoMakie
CairoMakie.activate!(type="svg")

Tree = BetaML.Trees.DecisionTreeClassifier

redirect_stdout(Pipe()) do

session = Pluto.ServerSession()
session.options.server.port = 40404
session.options.server.launch_browser = false
session.options.security.require_secret_for_access = false

path = tempname()
original = WARMUP_PLUTO_NOTEBOOK
# so that we don't overwrite the file:
Pluto.readwrite(original, path)

# @info "Loading notebook"
nb = Pluto.load_notebook(Pluto.tamepath(path));
session.notebooks[nb.notebook_id] = nb;

# @info "Running notebook"
Pluto.update_save_run!(session, nb, nb.cells; run_async=false, prerender_text=true)

# nice! we ran the notebook, so we already precompiled a lot

# some plotting;
function mandelbrot(z)
c = z     # starting value and constant shift
max_iterations = 20
for n = 1:max_iterations
    if abs(z) > 2
        return n-1
     end
    z = z^2 + c
end
return max_iterations
end
xs = -2.5:0.01:0.75
ys = -1.5:0.01:1.5
heatmap(xs, ys, (x, y) -> mandelbrot(x + im*y),
        colormap = Reverse(:deep))

# some MLJ:
X0, y = make_blobs()
X = DataFrame(X0)
model = Tree()
mach = machine(model, X, y)
fit!(mach, verbosity=0)
predict(mach, X)

# @info "Starting HTTP server"
# next, we'll run the HTTP server which needs a bit of nasty code
t = @async Pluto.run(session)

sleep(5)
# download("http://localhost:40404/")

# this is async because it blocks for some reason
@async Base.throwto(t, InterruptException())
sleep(2) # i am pulling these numbers out of thin air

end
@info "Warmup done"
