cd(@__DIR__)
using Pkg
Pkg.activate(@__DIR__)

Pkg.instantiate()

Pkg.develop(path=joinpath("..", "SpinePeriods.jl"))

include(joinpath(@__DIR__, "functions.jl"))