module Extentions
  module Null
    class Extention
      def render(*); end
      def process(*); end
      def to_token
        :null
      end
      def valid?(*); true end
    end
  end
end
