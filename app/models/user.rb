class User < ApplicationRecord
    has_secure_password
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  def is_admin?
    user_type == "admin"
  end
end
