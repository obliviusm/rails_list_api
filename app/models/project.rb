class Project < ApplicationRecord
  scope :filter_by_category, -> (str) { where("category ILIKE ?", "%#{str}%") }
end
