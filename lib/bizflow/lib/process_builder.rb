require_relative '../data_model/process'

module Bizflow
  module Lib
    class ProcessBuilder

      def build(blueprint_id, creator_id)
        bp = Bizflow::DataModel::ProcessBlueprint[blueprint_id]
        process = bp.add_process(
          name: bp.name,
          creator_id: creator_id,
          description: bp.description)

        bp.action_blueprints.each do |a|

          action = Bizflow::DataModel::Action.create(
            name: a.name,
            type: a.type,
            process: process,
            description: a.description,
            action_blueprint_id: a.id)
          
            process.update(start_action_id: action.id) if bp.start == a.name

        end

        process.add_head({})

        process
      end

    end
  end
end
