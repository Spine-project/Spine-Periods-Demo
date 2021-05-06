using SpineOpt, JSON

function add_temporal_blocks_to_spine_db(url::String, json_out::String)
    d = JSON.parsefile(json_out)
    SpineOpt.import_data(url, d, "Adding representative period temporal_blocks")
    return nothing
end

function add_temporal_block_relationships_to_spine_db(url::String)
    SpineOpt.using_spinedb(url, SpineOpt)

    rep_days = [tb for tb in temporal_block() if tb.name != Symbol(2017)]

    SpineOpt.import_data(
        url,
        Dict(
            :objects => [
                :temporal_block, :all_representative_periods
            ],
            :object_groups => [
                [
                    :temporal_block, :all_representative_periods, tb.id
                ]
                for tb in rep_days
            ],
        ),
        "Adding all_representative_periods group."
    )

    all_rep_days = first(
        tb for tb in temporal_block() if tb.name == :all_representative_periods
    )

    SpineOpt.import_data(
        url,
        Dict(
            :relationships => [
                [
                    :model__temporal_block, [:instance, :all_representative_periods],
                ]
            ],
        ),
        "Adding model__temporal_block relationship."
    )

    SpineOpt.import_data(
        url,
        Dict(
            :relationships => [
                [
                    :node__temporal_block, [n.name, :all_representative_periods],
                ]
                for n in SpineOpt.node()
            ],
        ),
        "Adding node__temporal_block relationship."
    )

    SpineOpt.import_data(
        url,
        Dict(
            :relationships => [
                [
                    :units_on__temporal_block, [u.name, :all_representative_periods],
                ]
                for u in SpineOpt.unit() # if u.name != Symbol("All Units")
            ]
        ),
        "Adding units_on__temporal_block relationship."
    )

    SpineOpt.import_data(
        url,
        Dict(
            :object_parameter_values => [
                [
                    :model, :instance, :roll_forward, nothing
                ]
            ]
        ),
        "Removing roll_forward parameter value"
    )
    
    return nothing
end

function clean_up_spine_dbs(args... ;force=false)
    if force == false
        yn = ""
        println("Remove recently created Spine DBs? [y/n]")
        while yn ∉ ("y","n")
            yn = readline()
            yn ∉ ("y","n") && println("Please answer either `y` or `n`.")
        end
    else
        yn = "y"
    end
    if yn == "y"
        for arg in args
            isfile(arg) == false && continue
            println("Removing $(arg) ...")
            rm(arg; force=true)
        end
    elseif yn == "n"
        println("Not removing anything.")
    else
        error()
    end
end

function duplicate_spine_db(db_url::String, db_url_out::String)
    cp(db_url, db_url_out; force=true)
end