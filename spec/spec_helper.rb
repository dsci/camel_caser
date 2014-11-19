require 'rspec'
require 'rack/test'
require 'multi_json'

Dir[File.join(File.dirname(__FILE__),"/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include RackAppHelper,  type: :rack 
  config.include RailsAppHelper, type: :rails
end
