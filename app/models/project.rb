class Project < ApplicationRecord
  belongs_to :user, optional: true
  scope :filter_by_category, -> (str) { where("category ILIKE ?", "%#{str}%") }
end
