require 'sequel'

module Bizflow

  module DataModel

    class Task < Sequel::Model

      many_to_one :action
      many_to_one :task_blueprint

    end

  end

end

