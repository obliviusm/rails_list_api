module Api
  class ProjectsController < ApplicationController
    include JSONAPI::ActsAsResourceController
    before_action :authenticate_user!

    def context
      if ['update', 'create'].include? action_name
        {current_user: current_user}
      else
        {}
      end
    end
  end
end
