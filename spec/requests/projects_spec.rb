require 'rails_helper'

RSpec.describe "Projects", :type => :request do
  describe "GET /api/projects" do
    it "returns all projects" do
      FactoryGirl.create :project, title: 'Github'
      FactoryGirl.create :project, title: 'Intercom'

      get '/api/projects', headers: {'ACCEPT' => "application/vnd.api+json"}
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_names = body['data'].map{|project| project['attributes']['title'] }
      expect(project_names).to match_array(['Github', 'Intercom'])
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
            foundedAt: '2011',
            image: 'https://rails-apps.com/uploads/app/screenshot/500/screenshot.png'
          }
        }
      }

      post '/api/projects',
        params: project.to_json,
        headers: {
          'CONTENT-TYPE': 'application/vnd.api+json',
          'ACCEPT' => "application/vnd.api+json"
        }

      expect(response.status).to eq 201

      body = JSON.parse(response.body)

      project_name = body['data']['attributes']['title']
      expect(project_name) == 'Intercom'
    end
  end
end
