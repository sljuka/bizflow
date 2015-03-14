require_relative '../data_model/process'

module Bizflow
  module Lib
    class BlueprintBuilder

      def build(semantic_repo)

        semantic_repo.processes.each do |p|

        	a = Bizflow::DataModel::ProcessBlueprint.create(
        		name: p.name,
        		description: p.description,
						start: p.start
      		)

        end

      end

    end
  end
end
