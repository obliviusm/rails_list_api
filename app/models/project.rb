class Project < ApplicationRecord
  belongs_to :user, optional: true
  scope :filter_by_category, -> (str) { where("category ILIKE ?", "%#{str}%") }
  scope :filter_by_user_email, -> (email) { joins(:user).where(users: {email: email}) }

  def user_email=(value)

  end

  def user_email
    self.user.try(:email)
  end
end
