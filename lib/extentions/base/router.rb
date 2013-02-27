module Extentions
  module Base
    class Router
      def initialize(controller, role, context)
        @controller, @role, @context = controller, role, context
      end

      def process; end
      def render; "" end

      private
      def context_action
        @context_action ||= context.action_name.to_sym
      end
    end
  end
end

