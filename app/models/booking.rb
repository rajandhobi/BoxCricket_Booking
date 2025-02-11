class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :payment, dependent: :destroy
  validates :status, presence: true
  validates :slot_id, uniqueness: { message: "This slot is already booked." }

end
