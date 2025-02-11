class Slot < ApplicationRecord
  belongs_to :ground
  has_one :booking, dependent: :destroy
  validates :start_time, :end_time, :price, presence: true
  STATUSES = %w[available booked pending cancelled]

  validates :status, inclusion: { in: STATUSES }


  before_create :set_default_status
  before_update :update_status_if_booking_changes

  private

  def set_default_status
    self.status ||= "available"
  end

  def update_status_if_booking_changes
    if booking.present? && status == "available"
      self.status = "booked"
    elsif booking.nil? && status == "booked"
      self.status = "available"
    end
  end
end
