class Slot < ApplicationRecord
  belongs_to :ground
  has_one :booking, dependent: :destroy
  validates :start_time, :end_time, :price, presence: true
  STATUSES = %w[available booked pending ]

  validates :status, inclusion: { in: STATUSES }


  before_create :set_default_status

  private

  def set_default_status
    self.status ||= "available"
  end

 

end
