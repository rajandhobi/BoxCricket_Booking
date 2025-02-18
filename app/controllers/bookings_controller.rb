class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_owner, only: [:show]


    def index
      if current_user.has_role?(:admin)
        @ground = Ground.find(params[:ground_id])  # Ensure admin sees only their ground’s bookings
        @bookings = @ground.slots.joins(:booking).includes(:booking).map(&:booking).compact
      else
        @bookings = Booking.includes(:slot, :user).where(user: current_user)
      end
    end
    
    def show
      @slot = Slot.find(params[:slot_id])
      @booking = @slot.booking
      @ground = @slot.ground
      @branch = @ground.branch
      @user = @booking.user if @booking.present?
  
      # Ensure admin can see only bookings of their own ground
      if current_user.has_role?(:admin) && @slot.ground.branch.user != current_user
        redirect_to root_path, alert: "Access denied! You are not authorized to view this booking."
      end
    end
    


    def create
      @slot = Slot.find_by(id: params[:slot_id])
      if @slot.nil?
        redirect_to branch_ground_slots_path(@branch, @ground), alert: "Slot not found" and return
      end
    
      authorize @slot, :book?
    
      if @slot.status == "available"
        @booking = @slot.create_booking(user: current_user, status: "pending") # Status set to pending
    
        if @booking.persisted?
          redirect_to new_branch_ground_slot_booking_payment_path(booking_id: @booking.id), notice: "Slot successfully booked! Proceed to payment."
        else
          redirect_to branch_ground_path(@slot.ground.branch, @slot.ground), alert: "Booking failed."
        end
      else
        redirect_to branch_ground_path(@slot.ground.branch, @slot.ground), alert: "Slot is already booked."
      end
    end
    
  


    def destroy
      slot = Slot.find_by(id: params[:slot_id])  # ✅ Fetch slot using slot_id
      
      if slot.nil?
        redirect_to root_path, alert: "Slot not found." and return
      end
    
      booking = slot.booking  # ✅ Fetch the booking associated with the slot
      
      if booking.nil?
        redirect_to root_path, alert: "Booking not found for this slot." and return
      end
    
      if booking.user == current_user  # ✅ Ensure only the owner can delete
        if booking.destroy
          slot.update(status: "available")  # ✅ Set slot back to "available"
          redirect_to request.referer, notice: "Booking deleted successfully."
        else
          redirect_to request.referer, alert: "Failed to delete booking."
        end
      else
        redirect_to root_path, alert: "You are not authorized to cancel this booking!"
      end
    end
    
      
  private

  
  def authorize_admin_or_owner
    unless current_user.has_role?(:admin) || @booking&.user == current_user
      redirect_to root_path, alert: "Access denied! You are not authorized to view this page."
    end
  end
  
      
    
end      