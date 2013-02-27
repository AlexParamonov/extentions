require_relative '../null/extention'
require_relative '../renderer' if defined? Rails

module Extentions
  module Base
    class Extention
      def self.apply(*params)
        extention = new(*params)
        extention.valid? ? extention : Null::Extention.new
      end

      def self.configure(&block)
        block.call(config)
      end

      def self.config
        @config ||= OpenStruct.new
      end

      def render
        router.render
      end

      def process
        router.process
      end

      def to_token
        self.class.name.split("::").at(1).downcase.to_sym
        # Naming.new(self).tokens.last
      end

      def valid?(*)
        raise NotImplementedError
      end

      private_class_method :new
      private
      attr_reader :model, :context

      def initialize(model, context)
        @model   = model
        @context = context
      end

      def config
        self.class.config
      end

      def view
        Extentions::Renderer.new(self)
      end

      def role
        Factory.new(config.adapter).role_for(model)
      end

      def controller
        Controller.new(model, view)
      end

      def router
        Router.new(controller, role, context)
      end

      def model_is_any_of?(*classes)
        # Note that '&' is the set intersection operator for Arrays.
        (classes.map(&:to_s) & model.class.ancestors.map(&:name)).any?
      end
    end
  end
end
