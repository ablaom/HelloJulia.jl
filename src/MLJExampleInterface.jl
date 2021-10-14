module MLJExampleInterface

# Example.jl doesn't actually provide machine learning models, so we
# provide a module below with the same name to furnish us with simple
# constant probabilistic classification. Note that `Example.fit`
# ignores the training features `Xmatrix`.

module Example

function fit(Xmatrix::Matrix, yint::AbstractVector{<:Integer})
    classes = sort(unique(yint))
    counts = [count(==(c), yint) for c in classes]
    Θ = counts / sum(counts)
end

predict(Xnew::Matrix, Θ) = vcat(fill(Θ', size(Xnew, 1))...)

# julia> yint = rand([1,3,4], 100);

# julia> Θ = fit(rand(100, 3), yint)
# 3-element Vector{Float64}:
#  0.35
#  0.23
#  0.42

# julia> predict(rand(5, 3), Θ)
# 5×3 Matrix{Float64}:
#  0.35  0.23  0.42
#  0.35  0.23  0.42
#  0.35  0.23  0.42
#  0.35  0.23  0.42
#  0.35  0.23  0.42

end # of module


### CONTINUATION OF TEMPLATE

import .Example # substitute model-providing package name here (no dot)
import MLJModelInterface
import ScientificTypesBase

const PKG = "Example"          # substitute model-providing package name
const MMI = MLJModelInterface
const STB = ScientificTypesBase

"""
    CoolProbabilisticClassifier()

A cool classifier that predicts `UnivariateFinite` probability
distributions. These are distributions for a finite sample space whose
elements are *labeled*.

"""
MMI.@mlj_model mutable struct CoolProbabilisticClassifier <: MMI.Probabilistic
    dummy_hyperparameter1::Float64 = 1.0::(_ ≥ 0)
    dummy_hyperparameter2::Int = 1::(0 < _ ≤ 1)
    dummy_hyperparameter3
end

function MMI.fit(::CoolProbabilisticClassifier, verbosity, X, y)

    Xmatrix = MMI.matrix(X)

    yint = MMI.int(y)
    decode = MMI.decoder(y[1])                # for decoding int repr.
    classes_seen = decode(sort(unique(yint))) # ordered by int repr.

    Θ = Example.fit(Xmatrix, yint)            # probability vector
    fitresult = (Θ, classes_seen)
    report = (n_classes_seen = length(classes_seen),)
    cache = nothing

    return fitresult, cache, report

end

function MMI.predict(::CoolProbabilisticClassifier, fitresult, Xnew)
    Xmatrix = MMI.matrix(Xnew)

    Θ, classes_seen = fitresult
    prob_matrix = Example.predict(Xmatrix, Θ)

    # `classes_seen` is a categorical vector whose pool actually
    # includes *all* classes. The `UnivariateFinite` constructor
    # automatically assigns zero probability to the unseen classes.

    return MMI.UnivariateFinite(classes_seen, prob_matrix)
end

# for returning user-friendly form of the learned parameters:
function MMI.fitted_params(::CoolProbabilisticClassifier, fitresult)
    Θ, classes_seen = fitresult
    return (raw_probabilities = Θ, classes_seen_in_training = classes_seen)
end


## META DATA

MMI.metadata_pkg(CoolProbabilisticClassifier,
             name="$PKG",
             uuid="7876af07-990d-54b4-ab0e-23690620f79a",
             url="https://github.com/JuliaLang/Example.jl",
             is_pure_julia=true,
             license="MIT",
             is_wrapper=false
)

MMI.metadata_model(CoolProbabilisticClassifier,
               input_scitype = MMI.Table(STB.Continuous),
               target_scitype = AbstractVector{<:STB.Finite},# ie, a classifier
               docstring = "Really cool classifier",         # brief description
               path = "$PKG.CoolProbabilisiticClassifier"
               )

end # module
