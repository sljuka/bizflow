require 'sequel'

module Bizflow

  module Model

    class Task < Sequel::Model

      many_to_one :block
      many_to_one :task_blueprint

    end

  end

end

