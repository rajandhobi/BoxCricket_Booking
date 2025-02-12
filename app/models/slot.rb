class Slot < ApplicationRecord
  belongs_to :ground
  has_one :booking, dependent: :destroy
  validates :start_time, :end_time, :price, presence: true
  STATUSES = %w[available booked pending ]

  validates :status, inclusion: { in: STATUSES }


  before_create :set_default_status
  # after_commit :update_status_if_booking_changes, on: [:update, :destroy]  # ✅ Runs after DB commit

  private

  def set_default_status
    self.status ||= "available"
  end

  # def update_status_if_booking_changes
  #   if booking.present?
  #     update_column(:status, "booked")  # ✅ Direct DB update
  #   else
  #     update_column(:status, "available")  # ✅ Now runs after booking is deleted
  #   end
  # end

end
