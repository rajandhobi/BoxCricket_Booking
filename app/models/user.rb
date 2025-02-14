
class User < ApplicationRecord
  rolify

  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :branches, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :payments, through: :bookings
  has_many :grounds, dependent: :destroy  # A user (admin) can create multiple grounds

  after_create :assign_default_role


  def superadmin?
    has_role?(:superadmin)
  end

  def admin?
    has_role?(:admin)
  end
  
  def user?
    has_role?(:user)
  end


  private

  def assign_default_role
    Rails.logger.debug "Assigning default role to user ID: #{self.id}"
    self.add_role(:user) if self.roles.blank?
    Rails.logger.debug "User roles after assignment: #{self.roles.pluck(:name)}"
  end

  
end
