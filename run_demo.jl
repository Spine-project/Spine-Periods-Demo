cd(@__DIR__)
using Pkg
Pkg.activate(@__DIR__)

using SpinePeriods, Cbc, JuMP, SpineOpt

include("functions.jl")

# Specify databases and files to be used
db_url_in = joinpath(@__DIR__, "data", "Belgium_2017_orderer.sqlite")
db_url_out = joinpath(@__DIR__, "data", "Belgium_2017_orderer_out.sqlite")
json_out = joinpath(@__DIR__, "data", "rep_days.json")
db_opt_url_out = joinpath(@__DIR__, "data", "Belgium_2017_orderer_opt_out.sqlite")

# If you change the number of days to be selected + ordered, then run this command:
duplicate_spine_db(db_url_in, db_url_out)

if false
    # The line below is for writing straight to a data base
    t = @elapsed(
        run_spine_periods("sqlite:///$(db_url_in)", "sqlite:///$(db_url_out)"; 
            with_optimizer=optimizer_with_attributes(
                Cbc.Optimizer, "logLevel" => 1, "ratioGap" => 0.01,
                "seconds" => 60*2
            )
        )
    )
else
    # The more flexible option is to write the output to a json and then import it
    t = @elapsed(
        run_spine_periods("sqlite:///$(db_url_in)", json_out; 
            with_optimizer=optimizer_with_attributes(
                Cbc.Optimizer, "logLevel" => 1, "ratioGap" => 0.01,
                "seconds" => 60*2
            )
        )
    )
end

print(
"""

SpinePeriods.jl run time: $(t) seconds

"""
)

add_temporal_blocks_to_spine_db("sqlite:///$(db_url_out)", json_out)

add_temporal_block_relationships_to_spine_db("sqlite:///$(db_url_out)")

t = @elapsed(
    m = run_spineopt("sqlite:///$(db_url_out)", "sqlite:///$(db_opt_url_out)")
)

print(
"""

SpineOpt.jl run time: $(t) seconds

"""
)

clean_up_spine_dbs(db_opt_url_out)