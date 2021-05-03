cd(@__DIR__)
using Pkg
Pkg.activate(@__DIR__)

Pkg.add(url="https://github.com/Spine-project/SpinePeriods.jl.git")

Pkg.instantiate()

include(joinpath(@__DIR__, "functions.jl"))