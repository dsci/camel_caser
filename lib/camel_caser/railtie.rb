module CamelCaser
  class Railtie < Rails::Railtie
    initializer "camel_caser.insert_middleware" do |app|
      app.config.middleware.insert_before "ActionDispatch::ParamsParser", 
                                         "CamelCaser::Middleware"
    end
  end
end
