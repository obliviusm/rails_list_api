class Project < ApplicationRecord
  belongs_to :user, optional: true
  scope :filter_by_category, -> (str) { where("category ILIKE ?", "%#{str}%") }

  def user_email=(value)

  end

  def user_email
    self.user.try(:email)
  end
end
