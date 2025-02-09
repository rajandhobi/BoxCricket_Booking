class Slot < ApplicationRecord
  belongs_to :ground
  has_many :bookings, dependent: :destroy
  validates :start_time, :end_time, :price, presence: true
end
