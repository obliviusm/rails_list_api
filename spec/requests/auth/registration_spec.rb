require 'rails_helper'

RSpec.describe "Auth Registration", :type => :request do
  describe "POST /api/auth" do
    it "registers" do
      user_json = {
        email: "user@email.com",
        password: "123secret",
        password_confirmation: "123secret"
      }

      post '/api/auth',
        params: user_json.to_json,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        }
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      
      expect(body['data']['id']).to be_present
      expect(body['data']['email']).to eq "user@email.com"
    end
  end
end
