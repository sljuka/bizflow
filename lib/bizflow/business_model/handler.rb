module Bizflow
  module BusinessModel
    
    class Handler < SimpleWrapper

      def handle
        raise NotImplementedError
      end

    end

  end
end