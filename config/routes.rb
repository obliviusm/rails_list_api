Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    jsonapi_resources :projects
    # this route will authorize visitors using the User class
    get 'demo/members_only', to: 'demo_user#members_only'
  end
end
