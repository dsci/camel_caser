require 'active_support/core_ext/string'
if ActiveSupport::VERSION::STRING.match(/3.\d+.\d+/)
  require 'camel_caser/core_ext/hash' 
end

module CamelCaser
  class Middleware
    
    def initialize(app)
      @app = app
    end
    
    def call(env)
      @app.call(convert_keys_to_camelcase(env))
    end

    private
    def handle_form_hash(env)
      params = env['rack.request.form_hash']
      unless params.empty?
        env['rack.request.form_hash'] = transform_params(params)
      end
    end
    
    def handle_raw_rack(env)
      params = env['rack.input'].gets
      unless params.empty?
        json = MultiJson.dump(transform_params(params))
        env['rack.input'] = StringIO.new(json)
        env['rack.input'].rewind   
      end
    end

    def transform_params(params)
      params = MultiJson.load(params) if params.is_a?(String)
      params.deep_transform_keys do |key|
        key.to_s.underscore
      end
    end
    
    def convert_keys_to_camelcase(env)
      if env.keys.include?("json-format")
        if env["json-format"].eql?("underscore")
          request = if defined?(Rails) 
            ActionDispatch::Request 
          else
            Rack::Request
          end.new(env)
          if request.post?
            if env["rack.request.form_hash"]
              handle_form_hash(env)
            else
              handle_raw_rack(env)
            end
          end
        end
      end
      env
    end

  end

end

