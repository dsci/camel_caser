module RackAppHelper
  include Rack::Test::Methods

  def app 
    Rack::Builder.parse_file(config_ru_path).first
  end

  private

  def config_ru_path
    File.expand_path(File.join(File.dirname(__FILE__),'..','apps','rack_app',
                                                          'config.ru'))
  end

end
