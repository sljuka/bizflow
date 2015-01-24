# this is a generated file. Don't modify it directly, since it will probably be regenerated later

require 'bizflow/external/business_process'

module Handlers
  module Breakfast
    MakeBreakfast = "temp"
    CheckSupplies = "temp"
  end
end

class MakeBreakfastProcess < Bizflow::BusinessProcess

  @dir = File.expand_path(__dir__)

  StartBlock = "check_supplies"

  Blocks = {
    check_supplies: {
      type: "auto",
      description: "checks if there are enaugh eggs, bacon and bread",
      handler: Handlers::Breakfast::CheckSupplies,
      next_blocks: {
        not_enaugh_supplies: "get_supplies",
        enaugh_supplies: "make_breakfast",
      }
    },
    make_breakfast: {
      type: "auto",
      description: "sets stove, fry eggs, roast bacon",
      handler: Handlers::Breakfast::MakeBreakfast,
      next_blocks: {
        success: "serve_breakfast",
      }
    },
    get_supplies: {
      type: "task",
      description: "get enaugh eggs, bacon and bread",
      next_block: "make_breakfast",
      tasks: [:get_bacon, :get_eggs, :get_bread]
    },
    serve_breakfast: {
      type: "task",
      description: "prepare table, slice bread",
      next_block: "process:finish",
      tasks: [:prepare_table, :slice_bread]
    },
  }

  Tasks = {
    get_bacon: {
      description: "optional description",
      roles: ["storage", "kitchen"]
    },
    get_eggs: {
      description: "",
      roles: ["storage", "kitchen"]
    },
    get_bread: {
      description: "",
      roles: ["storage"]
    },
    prepare_table: {
      description: "",
      roles: ["servers"]
    },
    slice_bread: {
      description: "",
      roles: ["kitchen"]
    },
  }

  def start_block
    StartBlock
  end

  def block_descriptors
    Blocks
  end

  def task_descriptors
    Tasks
  end

end
