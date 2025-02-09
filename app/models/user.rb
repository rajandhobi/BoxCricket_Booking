
class User < ApplicationRecord
  rolify

  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :branches, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :payments, through: :bookings


  # def superadmin?
  #   has_role?(:superadmin)
  # end

  # def admin?
  #   has_role?(:admin)
  # end
  
  # def user?
  #   has_role?(:user)
  # end
  
end
