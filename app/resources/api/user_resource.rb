module Api
  class UserResource < JSONAPI::Resource
    attributes :email
    has_many :projects
  end
end
