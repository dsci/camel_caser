require 'camel_caser/strategies/transform_params'
require 'camel_caser/transformable'
require 'camel_caser/strategies/form_hash'
require 'camel_caser/strategies/raw_input'

module CamelCaser
  class Middleware
    
    def initialize(app)
      @app = app
    end
    
    def call(env)
      @app.call(convert(env))
    end

    private
        
    def convert(env)
      if env.keys.include?("json-format")
        if env["json-format"].eql?("underscore")
          request = if defined?(Rails) 
            ActionDispatch::Request 
          else
            Rack::Request
          end.new(env)
          if request.post?
            strategy = if env["rack.request.form_hash"]
              Strategies::FormHash
            else
              Strategies::RawInput
            end
            strategy.handle(env)
          end
        end
      end
      env
    end

  end

end

