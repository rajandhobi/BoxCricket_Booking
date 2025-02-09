class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :payment, dependent: :destroy
  validates :status, presence: true
end
