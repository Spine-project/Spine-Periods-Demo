using Revise, SpinePeriods, Cbc, JuMP, SpineOpt

include("functions.jl")

# Specify databases to be used
db_url_in = joinpath(@__DIR__, "data", "Belgium_2017_orderer.sqlite")
db_url_out = joinpath(@__DIR__, "data", "Belgium_2017_orderer_out.sqlite")
db_opt_url_out = joinpath(@__DIR__, "data", "Belgium_2017_orderer_opt_out.sqlite")

run_spine_periods("sqlite:///$(db_url_in)", "sqlite:///$(db_url_out)"; 
    with_optimizer=optimizer_with_attributes(
        Cbc.Optimizer, "logLevel" => 1, "ratioGap" => 0.01,
        "seconds" => 60*2
    )
)

add_temporal_block_relationships_to_spine_db("sqlite:///$(db_url_out)")

m = run_spineopt("sqlite:///$(db_url_out)", "sqlite:///$(db_opt_url_out)")

clean_up_spine_dbs(db_url_out, db_opt_url_out)