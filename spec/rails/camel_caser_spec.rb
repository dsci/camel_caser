require 'spec_helper'

describe "camel caser middleware for Rails", type: :rails do 
  
  let(:json) do 
    MultiJson.dump({:userName => "dsci",bar:{ lordFoo: 12 }})
  end

  context "accept header is given" do 

    before do 
      post '/posts',json, {'json-format' => 'underscore',
                           "CONTENT_TYPE" => 'application/json'}
    end

    subject do 
      MultiJson.load(last_response.body)
    end

    it "converts lower camelcase to underscore params" do
      expect(subject).to have_key("keys")
      expect(subject["keys"]).to include("user_name")
      expect(subject["keys"]).to include("bar")
      expect(subject["keys"]).to include("lord_foo")
    end
    
  end

  context "accept header is not given" do
    before do 
      post '/posts', json, {"CONTENT_TYPE" => 'application/json'}
    end

    subject do 
      MultiJson.load(last_response.body)
    end

  
    it "did not convert lower camelcase to underscore params" do 
      expect(subject).to have_key("keys")
      expect(subject["keys"]).to include("userName")
    end
  end

end
