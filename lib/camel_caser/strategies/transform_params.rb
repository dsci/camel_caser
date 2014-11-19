require 'active_support/core_ext/string'
if ActiveSupport::VERSION::STRING.match(/3.\d+.\d+/)
  require 'camel_caser/core_ext/hash' 
end

module CamelCaser
  module Strategies
    class TransformParams
            
      def transform(params)
        params = MultiJson.load(params) if params.is_a?(String)
        params.deep_transform_keys do |key|
          key.to_s.underscore
        end
      end

    end
  end
end



