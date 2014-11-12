process "make_breakfast" do

  description "creates breakfast"

  namespace "breakfast"
  
  start_block "check_supplies"

  roles ["kitchen"]

  automated_block "check_supplies" do
    
    description "checks if there are enaugh eggs, bacon and bread"
    handler "breakfast:check_supplies"

    next_block(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

  end

  task_block "get_supplies" do

    description "get enaugh eggs, bacon and bread"
    tasks ["get_bacon", "get_eggs", "get_bread"]
    roles ["kitchen", "storage"]

    next_block "make_breakfast"

  end

  automated_block "make_breakfast" do

    description "sets stove, fry eggs, roast bacon"
    handler "breakfast:make_breakfast"

    next_block "serve_breakfast"
  end

  task_block "serve_breakfast" do

    description "prepare table, slice bread"
    tasks ["prepare_table, slice_bread"]

    next_block "process:finish"

  end


end
