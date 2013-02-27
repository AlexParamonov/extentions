module Extentions
  module Base
    class Factory
      def initialize(adapter = nil)
        @adapter = adapter
      end

      def role_for(model)
        raise NotImplementedError
      end

      private
      attr_reader :adapter
    end
  end
end
