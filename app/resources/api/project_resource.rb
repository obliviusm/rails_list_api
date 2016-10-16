module Api
  class ProjectResource < JSONAPI::Resource
    attributes :title, :founders, :headquarters, :category, :founded_at, :image
    has_one :user
    filter :category, apply: ->(records, value, _options) {
      records.filter_by_category(value.first)
    }
    
    def self.records(options = {})
      context = options[:context]
      context[:current_user].projects
    end

    before_save do
      @model.user_id = context[:current_user].id if @model.new_record?
    end
  end
end
