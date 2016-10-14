require 'rails_helper'

RSpec.describe "Demo User", :type => :request do

  describe "GET /api/demo/members_only" do
    before do
      @user = FactoryGirl.create :user, email: "user@email.com", password: "123secret"
      @auth_headers = @user.create_new_auth_token

      @token     = @auth_headers['access-token']
      @client_id = @auth_headers['client']
      @expiry    = @auth_headers['expiry']
    end

    it "rises error without token" do
      get '/api/demo/members_only', headers: {'Accept' => "application/vnd.api+json"}

      expect(response.status).to eq 401

      body = JSON.parse(response.body)
      expect(body['errors']).to eq ["Authorized users only."]
    end

    it "allows access with token" do
      get '/api/demo/members_only', headers: {'Accept' => "application/vnd.api+json"}.merge(@auth_headers)

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body['data']['message']).to eq "Welcome, user@email.com"
    end
  end
end
