require "extentions/version"
# THINK: Create, Find, Display extention parts
module Extentions
  def self.extentions_for(model, context = nil)
    Collection.new model, apply_extentions(model, context)
      # extentions.select do |extention|
      #   extention.applicable_to? params
      # end.map do |extention|
      #   extention.new(params)
      # end
  end

  def self.register(extention_class)
    @@extentions = extentions << extention_class
  end

  def self.reset
    @@extentions = []
  end

  private
  def self.apply_extentions(*params)
    extentions.map do |extention|
      extention.apply(*params)
    end
  end

  def self.extentions
    @@extentions ||= []
    @@extentions.uniq.compact
  end

  class Collection
    def initialize(model, extentions)
      @extentions = extentions
      @model = model
    end

    def process!(*params)
      extentions.each do |extention|
        extention.process(*params)
      end
    end

    def build_presenter
      rendered = extentions.each_with_object({}) do |extention, rendered|
        rendered[extention.to_token] = -> { extention.render }
      end
      Presenter.new(model, rendered)
    end

    private
    attr_reader :extentions, :model

    class Presenter < SimpleDelegator
      def initialize(model, attributes)
        @attributes = attributes
        super(model)
        # TODO is this really needed?
        __getobj__.pointer = self if __getobj__.respond_to? :pointer=
      end

      # TODO lazy init
      def method_missing(method, *args, &block)
        return cached[method] if cached.include? method

        if attributes.include? method
          @cached[method] = attributes[method].call.to_s.html_safe
        else
          super
        end
      end

      alias_method :__class__, :class
      def class
        __getobj__.class
      end

      def cached
        @cached ||= {}
      end
      private
      attr_reader :attributes
    end
  end
end
