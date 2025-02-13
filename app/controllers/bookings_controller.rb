class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_owner, only: [:show]


    def show
      @slot = Slot.find(params[:id])
      @booking = @slot.booking # Ensure booking is loaded
      @user = @booking.user if @booking.present? # Fetch the user who booked the slot

    end
      
  
    def create
      @slot = Slot.find_by(id: params[:slot_id])
      if @slot.nil?
        redirect_to branch_ground_slots_path(@branch, @ground), alert: "Slot not found" and return
      end
  
      authorize @slot, :book?
  
      if @slot.status == "available"
        puts "in slot"
        @booking = @slot.create_booking(user: current_user, status: "booked")
  
        if @booking.persisted?
          redirect_to ground_path(@slot.ground), notice: "Slot successfully booked!"
        else
          redirect_to ground_path(@slot.ground), alert: "Booking failed."
        end
      else
        redirect_to ground_path(@slot.ground), alert: "Slot is already booked."
      end
    end
  
    def destroy
      booking = Booking.find_by(params[:id])  # ✅ Find booking
      if booking
        slot = booking.slot  # ✅ Get associated slot
        if booking.destroy
          puts "Booking deleted successfully."
          puts slot
          if slot.update(status: "available")
            puts "Slot status updated to available."
          else
            puts "Failed to update slot status."
          end
          redirect_to root_path, notice: "Booking deleted successfully."
        else
          puts "Booking deletion failed."
          redirect_to root_path, alert: "Failed to delete booking."
        end
      else
        puts "Booking not found."
        redirect_to root_path, alert: "Booking not found."
      end
    end
      
  private

  
  def authorize_admin_or_owner
    unless current_user.has_role?(:admin) || @booking&.user == current_user
      redirect_to root_path, alert: "Access denied! You are not authorized to view this page."
    end
  end
  
      
    
end      