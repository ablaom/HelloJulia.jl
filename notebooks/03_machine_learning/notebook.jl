# # Tutorial 3

# An introduction to machine learning using MLJ and the Titanic
# dataset. Explains how to train a simple decision tree model and
# evaluate it's performance on a holdout set.

# MLJ is a *multi-paradigm* machine learning toolbox (i.e., not just
# deep-learning).

# For other MLJ learning resources see the [Learning
# MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/learning_mlj/)
# section of the
# [manual](https://alan-turing-institute.github.io/MLJ.jl/dev/).


# ## Activate package environment

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()


# ## Establishing correct data representation

using MLJ
import DataFrames

# A ["scientific
# type"](https://juliaai.github.io/ScientificTypes.jl/dev/) or
# *scitype* indicates how MLJ will *interpret* data (as opposed to how
# it is represented on your machine). For example, while we have

typeof(3.14)

# we have

scitype(3.14)

# and also

scitype(3.143f0)

# In MLJ, model data requirements are articulated using scitypes.

# Here are common "scalar" scitypes:

html"""
<div style="text-align: left";>
        <img src="https://github.com/ablaom/MLJTutorial.jl/blob/dev/notebooks/01_data_representation/scitypes.png?raw=true">
</div>
"""

# There are also container scitypes. For example, the scitype of any
# vector is `AbstractVector{S}`, where `S` is the scitype of its
# elements:

scitype(["cat", "mouse", "dog"])

# We'll be using [OpenML](https://www.openml.org/home) to grab the
# Titanic dataset:

table = OpenML.load(42638)
df0 = DataFrames.DataFrame(table)
DataFrames.describe(df0)

# The `schema` operator summarizes the column scitypes of a table:

schema(df0)

# Looks like we need to fix `:sibsp`, the number of siblings/spouses:

df1 = coerce(df0, :sibsp => Count)
schema(df1)

# Lets take a closer look at our target column :survived. Here a value
# `0` means that the individual didn't survive while a value of `1` indicates
# an individual survived.

levels(df1.survived)

# The `:cabin` feature has a lot of missing values, and low frequency
# for other classes:

import StatsBase
StatsBase.countmap(df0.cabin)

# We'll make `missing` into a bona fide class and group all the other
# classes into one:

function class(c)
    if ismissing(c)
        return "without cabin"
    else
        return "has cabin"
    end
end

# Shorthand syntax would be `class(c) = ismissing(c) ? "without cabin" :
# "has cabin"`. Now to transform the whole column:

df2 = DataFrames.transform(
    df1,
    :cabin => DataFrames.ByRow(class) => :cabin
) # :cabin now has `Textual` scitype
coerce!(df2, :class => Multiclass)
schema(df2)


# ## Splitting into train and test sets
# Here we split off 30% of our observations into a
# lock-and-throw-away-the-key holdout set, called `df_test`:

df, df_test = partition(df2, 0.7, rng=123)
DataFrames.nrow(df)

#-

DataFrames.nrow(df_test)


# ## Cleaning the data

# Let's construct an MLJ model to impute missing data:

cleaner = FillImputer()

# In MLJ a *model* is just a container for hyper-parameters associated with some ML
# algorithm. It does not store learned parameters (unlike scikit-learn "estimators"). In
# this case the hyper-parameters `features`, `continuous_fill`, `count_fill`, and
# `finite_fill` specify which features should be imputed and how imputation should be
# carried out, depending on the scitype. Since we didn't specify any features in our
# constructor, we are using default values.

# We now bind the model with training data in a *machine*:

machc = machine(cleaner, df)

# And train the machine to store learned parameters there (the column
# modes and medians to be used to impute missings):

fit!(machc);

# We can inspect the learned parameters if we want:

fitted_params(machc).filler_given_feature

# Next, we apply the learned transformation on our data:

dfc     =  transform(machc, df)
dfc_test = transform(machc, df_test)
schema(dfc)


# ## Split the data into input features and target

# The following method puts the column with name equal to `:survived`
# into the vector `y`, and everything else into a table (`DataFrame`)
# called `X`.

y, X = unpack(dfc, ==(:survived));
scitype(y)

# While we're here, we'll do the same for the holdout test set:

y_test, X_test = unpack(dfc_test, ==(:survived));


# ## Choosing a supervised model:

# There are not many models that can directly handle a mixture of
# scitypes, as we have here:

models(matching(X, y))

# This can be mitigated with further pre-processing (such as one-hot
# encoding) but we'll settle for one the above models here:

doc("DecisionTreeClassifier", pkg="BetaML")

#-

Tree = @load DecisionTreeClassifier pkg=BetaML  # model type
tree = Tree()                                   # default instance

# Notice that by calling `Tree` with no arguments we get default
# values for the various hyperparameters that control how the tree is
# trained. We specify keyword arguments to overide these defaults. For example:

small_tree = Tree(max_depth=3)

# A decision tree is frequently not the best performing model, but it
# is easy to interpret (and the algorithm is relatively easy to
# explain). For example, here's an diagramatic representation of a
# tree trained on (some part of) the Titanic data set, which suggests
# how prediction works:

html"""
<div style="text-align: left";>
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/58/Decision_Tree_-_survival_of_passengers_on_the_Titanic.jpg">
</div>
"""

# ## The fit/predict worflow

# We now the bind data to be used for training and evaluation to the model (ie, choice of
# hyperparameters) in a machine, just like we did for missing value imputation. In this
# case, however, we also need to specify the training target `y`:

macht = machine(tree, X, y)

# To train using *all* the bound data:

fit!(macht)

# And get predictions on the holdout set:

p = predict(macht, X_test);

# These are *probabilistic* predictions:

p[3]

#-

pdf(p[3], "0")

# We can also get "point" predictions:

yhat = mode.(p)

# We can evaluate performance using a probabilistic measure, as in

log_loss(p, y_test) |> mean

# Or using a deterministic measure:

accuracy(yhat, y_test)

# List all performance measures with `measures()`. Naturally, MLJ
# includes functions to automate this kind of performance evaluation,
# but this is beyond the scope of this tutorial. See, eg,
# [here](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/#Getting-Started).

# ## Learning more

# Some suggestions for next steps are
# [here](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/#Getting-Started).
