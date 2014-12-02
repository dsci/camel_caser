module CamelCaser
  module Strategies
    class RawInput
      include Transformable

      attr_reader :env
      
      def self.handle(env)
        self.new(env).handle
      end

      def initialize(env)
        @env = env
      end

      def handle 
        handle_raw_rack
      end

      private

      def handle_raw_rack
        params = @env['rack.input'].gets
        unless params.empty?
          json = MultiJson.dump(transform_params(params))
          @env['rack.input'] = StringIO.new(json)
          @env['rack.input'].rewind
          @env['CONTENT_LENGTH'] = json.length
        end
      end

    end
  end
end
