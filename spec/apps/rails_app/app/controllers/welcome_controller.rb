class WelcomeController < ApplicationController 
  respond_to :json 
  def index
    render json: {}
  end

  def posts
    not_acceptable_keys = ["controller", "format", "action", "welcome"]
    keys = params.reduce([]) do |result, (key,value)|
      unless key.in?(not_acceptable_keys)
        result << key
        if value.is_a?(Hash)
          result << value.keys
        end
      end
      result
    end

    render json: {keys: keys.flatten} 
  end

end
