# # Tutorial 2

# An introduction to data frames

# Loosely based on [this
# tutorial](https://juliaai.github.io/DataScienceTutorials.jl/data/dataframe/)
# from Data Science Tutorials.

# DataFrames.jl **cheatsheets**:
# [english](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1.pdf),
# [chinese](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1_zh.pdf)

# ## Setup

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()


# ## Loading some demonstration data

# We'll be using [OpenML](https://www.openml.org/home) to grab datasets.

using OpenML
using DataFrames

table = OpenML.load(42638); # Titanic data set
typeof(table)

# This is not a `DataFrame`. However, like
# [many](https://github.com/JuliaData/Tables.jl/blob/main/INTEGRATIONS.md)
# other tabular data containers in Julia, it can be converted to one in the
# obvious way:

df = DataFrame(table);

# A `DataFrame` is essentially just a wrapper around a number of
# vectors with names, conceptualized as a table with the vectors as
# columns.

# Lets' look the first few rows (observations) of `df`:

first(df, 4)

# Here's a summary of stats for each column:

describe(df)

# To get just the column names, use `names(df)`.


# ## Selecting a single entry:

number = df[5, :age]   # or df[5, 4]


# ## Selecting a single row:

# We use the wild-card `:`

row = df[5, :]

#-

number2 = row.age


# ## Selecting multiple rows

# By index:

small_df = df[3:7, :]

# By applying some criterion:

df2 = filter(df) do row
    row.age > 60 && row.survived == "1"
end

# (Alternatively, one can use `subset` or Boolean indexing; see the
# [cheatsheet](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1.pdf).)


# ## Selecting a single column

# Here's how I get the column named "Age":

df2.age

# Since this is just a vector, I can restrict the rows as usual:

df2.age[2:5]  # but same as df2[2:5, :Age]


# ## Selecting multiple columns - `select`

# The following wraps `df.age` as a single-column `DataFrame`:

select(df2, :age)

# ... which generalizes to multiple columns:

select(df2, [:age, :sex])

#-

select(df2, Not(:age))

#-

select(df2, Between(:sex, :fare))


# ## Copies or views of the data?

# So far, all the selection mechanisms discussed so far return a new
# `DataFrame` object, with these exceptions:

# * selecting a single row, as in `df[3,:]` - this returns a `DataFrameRow`.
# * selecting a single column as a vector, as in `df.age` - this returns a vector

# These exceptions are *views* of the original `DataFrame`, in the
# sense that no data is copied and mutating the view mutates the
# original `DataFrame`:

v = df.age;
v[1] = 1000
df[1, :age]

# Mutating the output of all the other selection mechanisms will not
# touch the original `DataFrame`, as data is copied in those cases.

# Use `select!` to make "in-place" column selections which mutate the
# original `DataFrame`. For example, the following permanently drops a
# column from `df`:

select!(df, Not(:cabin));
first(df, 2)

# In addition to row and column views of a `DataFrame` we can construct
# larger views, of type `SubDataFrame`, which share most of the
# behviour of an ordinary `DataFrame`, except they only *point* to
# data in the parent `DataFrame`, rather than duplicate it:

df_copy = df[1:3, [:fare, :age]]       # this is copy
df_view = @view df[1:3, [:fare, :age]] # this is a view

#-

df_view[1, :age] = 4000
df[1, :age]

#-

df_copy[1, :age]


# ## Describing the data

# To broaden the summary provided by `describe(df)` we can pass a
# number of symbols to indicate the statistics we are after:

describe(df, :min, :max, :mean, :median, :std)

# The following are all supported:
# * `mean`, `std`, `min`, `max`, `median`, `first`, `last` are all fairly self explanatory
# * `q25`, `q75` are respectively for the 25th and 75th percentile,
# * `eltype`, `nunique`, `nmissing` can also be used

# You can also pass your custom function with a pair `function =>
# :name` for instance:

using Statistics # to get functions like `mean` and `std`
foo(v) = mean(abs.(v))
d = describe(df, :mean, :median, foo => :mae)
first(d, 3)

# Note that the object returned by `describe` is itself a `DataFrame`:

select(d, [:variable, :mean])


# ## Materializing as a matrix
#
# To convert the content of the dataframe as one big matrix do this:
# use `convert`:

mat = Matrix(df)
mat[1:3, 1:3]


# ## Adding columns

# Adding a column to a dataframe is very easy:

df.weird = df.fare ./ df.age;
first(df, 3)

# That's it! Remember also that you can drop columns or make
# subselections with `select` and `select!`.

# The remainder of this tutorial is an abbreviated version of a
# [DataFrames.jl
# tutorial](http://juliadata.github.io/DataFrames.jl/latest/man/split_apply_combine/).

iris = OpenML.load(61) |> DataFrame;
first(iris, 3)

# ## `groupby`
#
# The `groupby` function allows to form "sub-dataframes" corresponding
# to groups of rows.  This can be very convenient to run specific
# analyses for specific groups without copying the data.

# The basic usage is `groupby(df, cols)` where `cols` specifies one or
# several columns to use for the grouping.

# Consider a simple example: in `iris` there is a `Species` column
# with 3 species:

unique(iris.class)

# We can form views for each of these:

gdf = groupby(iris, :class);

# The `gdf` object now corresponds to **views** of the original
# dataframe for each of the 3 species; the first species
# is `"Iris-setosa"` with:

subdf_setosa = gdf[1];
typeof(subdf_setosa)

#-

describe(subdf_setosa, :min, :mean, :max)

# Recall that this means modifying `subdf_setosa` also modifies its
# parent `iris`.

# Do `?groupby` for more information.


# ## `combine`

# The `combine` function allows to derive a new dataframe out of
# transformations of an existing one.  Here's an example taken from
# the official doc (see `?combine`):

df3 = DataFrame(a=1:3, b=4:6)

#-

combine(df3, :a => sum, nrow)

# What happened here is that the derived DataFrame has two columns
# obtained respectively by (1) computing the sum of the first column
# and (2) applying the `nrow` function on the `df`.
#
# The transformation can produce one or several values, and `combine` will
# try to accomodate this with appropriate packing:

goo(v) = v[1:2]
combine(df3, :a => maximum, :b => goo)

# Here the maximum value of `a` is copied twice so that the two
# columns have the same number of rows.

bar(v) = v[end-1:end]
combine(df3, :a => goo, :b => bar)


# ## `combine` with `groupby`
#
# Combining `groupby` with `combine` is very useful.  For instance you
# might want to compute statistics across groups for different
# variables:

combine(groupby(iris, :class), :petallength => mean)

# Let's break this operatioin down:
#
# 1. The `groupby(iris, :class)` creates groups using the `:class` column (which has values `Iris-setosa`, `Iris-versicolor`, `Iris-virginica`)
# 2. The `combine` creates a derived dataframe by applying the `mean` function to the `:petallength` column
# 3. Since there are three groups, we get one column (mean of `petallength`) and three rows (one per group).
#
#
# You can do this for several columns/statistics at the time and give
# new column names to the results:

gdf3 = groupby(iris, :class)
combine(gdf3, :petallength => mean => :MPL, :petallength => std => :SPL)

# So here we assign the names `:MPL` and `:SPL` to the derived
# columns.  If you want to apply something on all columns apart from
# the grouping one, using `names` and `Not` comes in handy:

combine(gdf3, names(iris, Not(:class)) .=> std)

# where

names(iris, Not(:class))

# and note the use of `.` in `.=>` to indicate that we broadcast the
# function over each column.
