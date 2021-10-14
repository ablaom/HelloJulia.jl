# MLJExampleInterface.jl

This repository is a template for creating repositories that contain
glue code between (i) packages providing machine learning algorithms; and (ii)
the machine learning toolbox
[MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/) - that is,
for so-called *interface-only packages*.

## When to use this template

This template is intended for use when a package providing a machine
learning model algorithm is not hosting the code that implements the
MLJ model API, and a separate package for this purpose is to be
created. This repo is itself a working implementation but should
be used in conjunction with the more detailed [model implementation
guidelines](https://alan-turing-institute.github.io/MLJ.jl/dev/adding_models_for_general_use/).

## How to use this template

1. Clone this repository or use it as a template if available from your organization. 

2. Rename this repository, replacing the word "Example" with the name of the model-providing package.

1. Develop the contents of src/MLJExampleInterface.jl appropriately.

2. Rename src/MLJExampleInterface.jl appropriately.

3. Remove Example from Project.toml and instead add the model-providing package.

3. **GENERATE A NEW UUID in Project.toml** and change the Project.toml
   name and author appropriately.
   
1. You may want to remove the Distributions test dependency if you don't need it.

4. Replace every instance of "Example" in this README.md with the name
   of the model-providing package and adjust the organization name in
   the link.

5. Remove everything in this REAMDE.md except what is below the line
   you are currently reading &#128521;.


# MLJ.jl <--> Example.jl

Repository implementing the [MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/) model interface for models provided by
[Example.jl](https://github.com/JuliaLang/Example.jl).

| Linux | Coverage |
| :------------ | :------- |
| [![Build Status](https://github.com/JuliaAI/MLJExampleInterface.jl/workflows/CI/badge.svg)](https://github.com/JuliaAI/MLJExampleInterface.jl/actions) | [![Coverage](https://codecov.io/gh/JuliaAI/MLJExampleInterface.jl/branch/master/graph/badge.svg)](https://codecov.io/github/JuliaAI/MLJExampleInterface.jl?branch=master) |
