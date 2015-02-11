module Bizflow
  module Business
    
    class Handler < SimpleWrapper

      def handle
        raise NotImplementedError
      end

    end

  end
end