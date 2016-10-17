require 'rails_helper'

RSpec.describe "Auth Registration", :type => :request do
  describe "POST /api/auth" do
    it "registers if user is good" do
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

    it "returns errors if user is bad" do
      user_json = {
        email: "user@email",
        password: "123secret",
        password_confirmation: "badpass"
      }

      post '/api/auth',
        params: user_json.to_json,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        }
      expect(response.status).to eq 422

      body = JSON.parse(response.body)

      expect(body['errors']['email']).to eq ["is not an email"]
      expect(body['errors']['password_confirmation']).to eq ["doesn't match Password"]
    end
  end
end
