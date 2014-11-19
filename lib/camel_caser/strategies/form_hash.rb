module CamelCaser
  module Strategies
    class FormHash
      include Transformable

      attr_reader :env

      def self.handle(env)
        self.new(env).handle
      end

      def initialize(env)
        @env = env
      end

      def handle
        handle_form_hash
      end

      private 

      def handle_form_hash
        params = @env['rack.request.form_hash']
        unless params.empty?
          @env['rack.request.form_hash'] = transform_params(params)
        end
      end

    end
  end
end

