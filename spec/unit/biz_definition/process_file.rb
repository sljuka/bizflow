
process "make_breakfast" do

  description "creates breakfast"

  namespace "breakfast"
  
  start_block "check_supplies"

  roles ["kitchen"]

  automated_block "check_supplies" do
    
    description "checks if there are enaugh eggs, bacon and bread"
    handler "breakfast:check_supplies", "code which checks the supplies"

    next_blocks(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

  end

  task_block "get_supplies" do

    description "get enaugh eggs, bacon and bread"
    task "get_bacon", ["storage", "kitchen"], "optional description"
    task "get_eggs", ["storage", "kitchen"]
    task "get_bread", ["storage"]
    next_block "make_breakfast"

  end

  automated_block "make_breakfast" do

    description "sets stove, fry eggs, roast bacon"
    handler "breakfast:make_breakfast"

    next_blocks(success: "serve_breakfast")
  end

  task_block "serve_breakfast" do

    description "prepare table, slice bread"
    task "prepare_table", ["servers"]
    task "slice_bread", ["kitchen"]

    next_block "process:finish"

  end


end
