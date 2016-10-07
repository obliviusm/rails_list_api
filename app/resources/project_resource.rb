class ProjectResource < JSONAPI::Resource
  attributes :title, :founders, :headquarters, :category, :founded_at, :image
end
