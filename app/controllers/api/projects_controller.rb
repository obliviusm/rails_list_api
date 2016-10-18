module Api
  class ProjectsController < ApplicationController
    include JSONAPI::ActsAsResourceController
    before_action :authenticate_user!

    def context
      {current_user: current_user}
    end
  end
end
