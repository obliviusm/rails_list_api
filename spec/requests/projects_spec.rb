require 'rails_helper'

RSpec.describe "Projects", :type => :request do

  before do
    @user = FactoryGirl.create :user, email: "user@email.com", password: "123secret"
    @auth_headers = @user.create_new_auth_token

    @token     = @auth_headers['access-token']
    @client_id = @auth_headers['client']
    @expiry    = @auth_headers['expiry']
  end

  describe "GET /api/projects" do
    it "returns all projects" do
      FactoryGirl.create :project, title: 'Github', user: @user
      FactoryGirl.create :project, title: 'Intercom', user: @user
      FactoryGirl.create :project, title: 'Uber'

      get '/api/projects', headers: {'Accept' => "application/vnd.api+json"}.merge(@auth_headers)

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_names = body['data'].map{|project| project['attributes']['title'] }
      expect(project_names).to match_array(['Github', 'Intercom', 'Uber'])
    end
  end

  describe "POST /api/projects" do
    it "creates the specified project" do
      project = {
        data: {
          type: "projects",
          attributes: {
            title: 'Intercom',
            founders: 'Eoghan McCabe, Des Traynor, Ciaran Lee, & David Barrett',
            headquarters: 'San Francisco',
            category: 'Analytics',
            "founded-at": '2011',
            image: 'https://rails-apps.com/uploads/app/screenshot/500/screenshot.png',
            "user-email": "email"
          }
        }
      }

      post '/api/projects',
        params: project.to_json,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        }.merge(@auth_headers)
        # body = JSON.parse(response.body)
        # p body
      expect(response.status).to eq 201

      body = JSON.parse(response.body)
      project_name = body['data']['attributes']['title']
      expect(project_name) == 'Intercom'
    end
  end

  describe "PATCH /api/projects/#" do
    before do
      project_hash = {
        data: {
          type: "projects",
          id: project.id,
          attributes: {
            title: 'Intercom',
            founders: 'Eoghan McCabe, Des Traynor, Ciaran Lee, & David Barrett',
            headquarters: 'San Francisco',
            category: 'Analytics',
            "founded-at": '2011',
            image: 'https://rails-apps.com/uploads/app/screenshot/500/screenshot.png',
            "user-email": "email"
          }
        }
      }

      patch "/api/projects/#{project.id}",
        params: project_hash.to_json,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        }.merge(@auth_headers)
    end

    describe "updates if it's users record" do
      let(:project) { project = FactoryGirl.create :project, title: 'Github', user: @user }

      it do
        body = JSON.parse(response.body)
        expect(response.status).to eq 200

        body = JSON.parse(response.body)
        project_name = body['data']['attributes']['title']
        expect(project_name) == 'Intercom'
      end
    end

    describe "doesn't allow to update other guy's project" do
      let(:project) { project = FactoryGirl.create :project, title: 'Github' }

      it do
        body = JSON.parse(response.body)
        expect(response.status).to eq 404
      end
    end
  end
end
