
process "make_breakfast" do

  description "creates breakfast"
  
  start "check_supplies"

  input_action "check_supplies" do
    
    description "checks if there are enaugh eggs, bacon and bread"
    question "Are there enaugh supplies?"

    next_actions(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

  end

  task_action "get_supplies" do

    description "get enaugh eggs, bacon and bread"
    task "get_bacon", roles: ["storage", "kitchen"], description: "optional description", auto_assign: true
    task "get_eggs", roles: ["storage", "kitchen"]
    task "get_bread", roles: ["storage"]

    next_action "make_breakfast"

  end

  task_action "make_breakfast" do

    description "sets stove, fry eggs, roast bacon"
    task "make_breakfast", roles: ["kitchen"]

    next_action "serve_breakfast"
    
  end

  task_action "serve_breakfast" do

    task "prepare_table", roles: ["servers"]
    task "slice_bread", roles: ["kitchen"]

    next_action "process:finish"

  end


end
