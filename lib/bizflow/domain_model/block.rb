module Bizflow
  class Block

    attr_reader :name, :description, :type

    def initialize(type, name)
      @type = type
      @name = name
      @description = nil
    end

  end
end
