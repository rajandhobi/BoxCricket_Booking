class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_owner, only: [:show]


    # def index
    #   if current_user.has_role?(:admin) # Only admins can view all bookings
    #     @bookings = Booking.includes(:slot, :user).all
    #   else
    #     @bookings = Booking.includes(:slot, :user).where(user: current_user) # Normal users see only their bookings
    #   end
    # end
    
    def show
      @slot = Slot.find(params[:slot_id])
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
          redirect_to branch_ground_path(@slot.ground.branch, @slot.ground), notice: "Slot successfully booked!"
        else
          redirect_to branch_ground_path(@slot.ground.branch, @slot.ground), alert: "Booking failed."
        end
      else
        redirect_to branch_ground_path(@slot.ground.branch, @slot.ground), alert: "Slot is already booked."
      end
    end
  
    # def destroy
    #   booking = Booking.find_by(params[:id])  # ✅ Find booking
    #   if booking
    #     slot = booking.slot  # ✅ Get associated slot
    #     if booking.destroy
    #       puts "Booking deleted successfully."
    #       puts slot
    #       if slot.update(status: "available")
    #         puts "Slot status updated to available."
    #       else
    #         puts "Failed to update slot status."
    #       end
    #       redirect_to request.referer, notice: "Booking deleted successfully."
    #     else
    #       puts "Booking deletion failed."
    #       redirect_to request.referer, alert: "Failed to delete booking."
    #     end
    #   else
    #     puts "Booking not found."
    #     redirect_to root_path, alert: "Booking not found."
    #   end
    # end


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