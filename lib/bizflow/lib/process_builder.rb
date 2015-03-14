require_relative '../data_model/process'

module Bizflow
  module Lib
    class ProcessBuilder

      def build(blueprint_id, creator_id)

        actions_map = {}

        bp = Bizflow::DataModel::ProcessBlueprint.where(id: blueprint_id).eager(:action_blueprints => [:next_action_blueprints]).all.first
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
          
          actions_map[a.name] = action.id

          process.update(start_action_id: action.id) if bp.start == a.name

        end

        bp.action_blueprints.each do |abp|

          abp.next_action_blueprints.each do |nbp|

            acc = Bizflow::DataModel::NextAction.create(
              action_id: actions_map[nbp.action_blueprint.name],
              next_id: actions_map[nbp.next_blueprint.name]
            )

          end

        end

        process.add_head({})


        process
      end

    end
  end
end
