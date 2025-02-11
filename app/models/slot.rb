class Slot < ApplicationRecord
  belongs_to :ground
  has_one :booking, dependent: :destroy
  validates :start_time, :end_time, :price, presence: true
  STATUSES = %w[available booked pending cancelled]

  validates :status, inclusion: { in: STATUSES }
end
