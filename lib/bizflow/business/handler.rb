module Bizflow
  module Business
    
    class Handler < SimpleWrapper

      # TODO what about merge
      def handle
        raise NotImplementedError
      end

    end

  end
end