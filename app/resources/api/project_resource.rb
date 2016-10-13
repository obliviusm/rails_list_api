module Api
  class ProjectResource < JSONAPI::Resource
    attributes :title, :founders, :headquarters, :category, :founded_at, :image
    filter :category, apply: ->(records, value, _options) {
      records.filter_by_category(value.first)
    }
  end
end
