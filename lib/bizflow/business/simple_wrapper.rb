require 'delegate'

module Bizflow

  class SimpleWrapper < SimpleDelegator

    def self.wrap(item)
      new item
    end

    def self.wraps(items)
      res = items.map do |item|
        new item
      end

      res
    end

  end
end