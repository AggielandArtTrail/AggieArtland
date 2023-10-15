class User < ApplicationRecord
    has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def is_admin?
    user_type == "admin" or name.include? "_admin" # name check is just for testing!
  end
end
