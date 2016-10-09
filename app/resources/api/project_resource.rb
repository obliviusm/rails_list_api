module Api
  class ProjectResource < JSONAPI::Resource
    attributes :title, :founders, :headquarters, :category, :founded_at, :image
    filter :category, apply: ->(records, value, _options) {
      records.where("category LIKE LOWER(?)", "%#{value.first.downcase}%")
    }
  end
end
