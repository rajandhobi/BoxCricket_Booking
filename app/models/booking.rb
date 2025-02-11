class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :payment, dependent: :destroy
  validates :status, presence: true
  validates :slot_id, uniqueness: { message: "This slot is already booked." }

  # Callbacks to update slot status
  after_create :mark_slot_as_booked
  after_update :update_slot_status_on_cancellation

  private

  def mark_slot_as_booked
    slot.update(status: "booked") if status == "booked"
  end

  def update_slot_status_on_cancellation
    if saved_change_to_status? && status == "cancelled"
      slot.update(status: "available")
    end
  end


end
