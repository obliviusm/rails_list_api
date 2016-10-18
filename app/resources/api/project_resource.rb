module Api
  class ProjectResource < JSONAPI::Resource
    attributes :title, :founders, :headquarters, :category, :founded_at, :image
    attribute :user_email
    has_one :user
    filter :category, apply: ->(records, value, _options) {
      records.filter_by_category(value.first)
    }

    filter :user_email, apply: ->(records, value, _options) {
      records.filter_by_user_email(value.first)
    }

    def self.records(options = {})
      context = options[:context]
      if context[:current_user]
        context[:current_user].projects
      else
        Project.all
      end
    end

    before_save do
      @model.user_id = context[:current_user].id if @model.new_record?
    end
  end
end
