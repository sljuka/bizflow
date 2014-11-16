module Processes
  module Breakfast
    class MakeBreakfast < Bizflow::BusinessProcess

      Blocks = {
      
        check_supplies: {
          description: "checks if there are enaugh eggs, bacon and bread",
          handler: Handlers::Breakfast::CheckSupplies,
          next_blocks: { 
            not_enaugh_supplies: "get_supplies", 
            enaugh_supplies: "make_breakfast",
          }
        },
        
        make_breakfast: {
          description: "sets stove, fry eggs, roast bacon",
          handler: Handlers::Breakfast::MakeBreakfast,
          next_blocks: { 
            success: "serve_breakfast",
          }
        },
        
      
        get_supplies: {
          description: "get enaugh eggs, bacon and bread",
          next_block: "make_breakfast",
          tasks: [:get_bacon, :get_eggs, :get_bread]
        },
        
        serve_breakfast: {
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

    end
  end
end
