require 'rails_helper'

RSpec.describe "Projects", :type => :request do
  describe "GET api/projects" do
    it "returns all the projects" do
      FactoryGirl.create :project, title: 'Github'
      FactoryGirl.create :project, title: 'Intercom'

      get '/api/projects', headers: {'HTTP_ACCEPT' => "application/vnd.api+json"}
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_names = body['data'].map{|project| project['attributes']['title'] }
      expect(project_names).to match_array(['Github', 'Intercom'])
    end
  end
end
