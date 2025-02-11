class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  before_create :generate_api_key


  ROLES = %w[admin moderator user]



  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end

  def user?
    role == "user" || role.blank?
  end

  def full_name
    name.presence || email
  end



  before_save :set_default_role
  private

  def set_default_role
    self.role ||= "user"
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(20)
  end
end
