require 'sequel'

module Bizflow

  module Model

    class Task < Sequel::Model

      many_to_one :action
      many_to_one :task_blueprint

    end

  end

end

