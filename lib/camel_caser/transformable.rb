module CamelCaser
  module Transformable
    module_function

    def transform_params(params)
      CamelCaser::Strategies::TransformParams.new.transform(params)
    end
  end
end
