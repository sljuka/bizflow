
process "make_breakfast" do

  description "creates breakfast"
  
  start_block "check_supplies"


  automated_block "check_supplies" do
    
    description "checks if there are enaugh eggs, bacon and bread"
    handler "check_supplies", namespace: "breakfast", description: "code which checks the supplies"

    next_blocks(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

  end

  task_block "get_supplies" do

    description "get enaugh eggs, bacon and bread"
    task "get_bacon", roles: ["storage", "kitchen"], description: "optional description", auto_assign: true
    task "get_eggs", roles: ["storage", "kitchen"]
    task "get_bread", roles: ["storage"]

    next_block "make_breakfast"

  end

  automated_block "make_breakfast" do

    description "sets stove, fry eggs, roast bacon"
    handler "make_breakfast", namespace: "breakfast"

    next_blocks(success: "serve_breakfast")
    
  end

  task_block "serve_breakfast" do

    description "prepare table, slice bread"
    task "prepare_table", roles: ["servers"]
    task "slice_bread", roles: ["kitchen"]

    next_block "process:finish"

  end


end
