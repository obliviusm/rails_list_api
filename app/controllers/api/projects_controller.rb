module Api
  class ProjectsController < ApplicationController
    include JSONAPI::ActsAsResourceController
    before_action :authenticate_user!
  end
end
