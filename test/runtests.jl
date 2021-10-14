using MLJExampleInterface # substitute for correct interface pkg name
using Test
using MLJBase
import Distributions
using StableRNGs # for RNGs stable across all julia versions
rng = StableRNGs.StableRNG(123)

@testset "cool classifier" begin
    n = 100
    p = 3
    nclasses = 5
    X, y = make_blobs(n, p, centers=nclasses, rng=rng);
    model = MLJExampleInterface.CoolProbabilisticClassifier()
    mach = machine(model, X, y)
    fit!(mach, rows=1:2, verbosity=0)
    yhat = predict(mach, rows=3)
    @test size(Distributions.pdf(yhat, levels(y)) ) == (1, nclasses)

    e = evaluate!(mach, measure=BrierLoss(), verbosity=0)
    @test e.measurement[1] < 1.0

    @test fitted_params(mach).classes_seen_in_training == levels(y)
    @test report(mach).n_classes_seen == nclasses
end
