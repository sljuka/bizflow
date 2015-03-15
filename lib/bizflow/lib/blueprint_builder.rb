require 'bizflow/data_model/process_blueprint'
require 'bizflow/data_model/action_blueprint'
require 'bizflow/data_model/task_blueprint'
require 'bizflow/data_model/next_action_blueprint'

module Bizflow
  module Lib
    class BlueprintBuilder

      def build(semantic_repo)

        semantic_repo.processes.each do |p|

          # processes

        	process = Bizflow::DataModel::ProcessBlueprint.create(
        		name: p.name,
        		description: p.description,
						start: p.start
      		)

          p.actions.each do |a|

            # actions

            action = process.add_action_blueprint(
              name: a.name,
              type: a.type,
              description: a.description
            )

            # tasks

            a.tasks.each do |t|
              action.add_task_blueprint(
                name: t.name,
                roles: t.roles.join(" "),
                description: t.description
              )
            end

          end

          data_actions = process.action_blueprints

          # next_actions

          p.actions.each do |a|

            a.next_actions.each do |k, v|

              ending = nil
              ending = k.to_s if k != :only_one

              current_action = data_actions.select { |acc| acc.name == a.name }.first
              next_action = data_actions.select { |acc| acc.name == v }.first

              Bizflow::DataModel::NextActionBlueprint.create(
                action_blueprint: current_action,
                next_blueprint: next_action,
                ending: ending
              )

            end

          end

        end

      end

      private

      def handle_next_blueprints(action)
        res = []
        if action.type == "task"
          res = Bizflow::DataModel::NextActionBlueprint.new()
        elsif action.type == "input"

        else

        end


      end

    end
  end
end
