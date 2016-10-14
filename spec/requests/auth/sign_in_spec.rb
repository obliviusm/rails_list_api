require 'rails_helper'

RSpec.describe "Auth/Sign in", :type => :request do
  describe "POST /api/auth/sign_in" do
    it "returns user and token" do
      user = FactoryGirl.create :user, email: "user@email.com", password: "123secret"
      # auth_headers = user.create_new_auth_token
      user_json = {
        email: user.email,
        password: "123secret"
      }

      post '/api/auth/sign_in',
        params: user_json.to_json,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        }
      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      expect(body['data']['email']).to eq user.email
      expect(response.headers['expiry'].to_i).to eq user.reload.tokens[response.headers['client']]['expiry']
    end
  end
end
