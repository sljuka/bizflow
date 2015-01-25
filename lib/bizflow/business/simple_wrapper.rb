require 'delegate'

module Bizflow
  module Business
    
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
end