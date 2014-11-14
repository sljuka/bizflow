module Processes
  module Breakfast
    class MakeBreakfast < Bizflow::BusinessProcess

      Blocks = {
        
        check_supplies: {
          description: "checks if there are enaugh eggs, bacon and bread"
          handler: Handlers::Breakfast::CheckSupplies,
          next_blocks: {
            not_enaugh_supplies: get_supplies,
            enaugh_supplies: make_breakfast,
          }
        },
        
        make_breakfast: {
          description: "sets stove, fry eggs, roast bacon"
          handler: Handlers::Breakfast::MakeBreakfast,
          next_blocks: {
            success: serve_breakfast,
          }
        },
        
      }

      Tasks = {

      }

    end
  end
end
