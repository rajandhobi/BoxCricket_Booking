class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one :payment, dependent: :destroy
  validates :status, presence: true
  validates :slot_id, uniqueness: { message: "This slot is already booked." }

  # Callbacks to update slot status
  after_create :mark_slot_as_booked
  after_destroy :reset_slot_status # When booking is deleted, slot becomes available

  # after_update :update_slot_status_on_cancellation

  private

  def mark_slot_as_booked
    slot.update(status: "booked") if status == "booked"
  end

 

  def reset_slot_status
    if slot.present?
      slot.update_column(:status, "available")  # 🚀 Direct DB update without validation
      puts "Slot status set to available using update_column."
    else
      puts "Slot not found while resetting status."
    end
  end
  

end
