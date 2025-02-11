class BookingsController < ApplicationController
    before_action :authenticate_user!

    def show
        @slot = Slot.find(params[:id])
        @booking = @slot.booking # Ensure booking is loaded
      end
      
  
    def create
      @slot = Slot.find_by(id: params[:slot_id])
      if @slot.nil?
        redirect_to branch_ground_slots_path(@branch, @ground), alert: "Slot not found" and return
      end
  
      authorize @slot, :book?
  
      if @slot.booking.nil?
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
        @booking = Booking.find_by(id: params[:id])
        
        if @booking.nil?
          redirect_to root_path, alert: "Booking not found" and return
        end
      
        @ground = @booking.slot.ground
        @branch = @ground.branch
      
        authorize @booking  # Ensure the user has permission to cancel
      
        if @booking.destroy
          puts "Booking successfully deleted!"  # Debugging log
          redirect_to branch_ground_slots_path(@branch, @ground), notice: "Booking canceled successfully."
        else
          puts "Failed to delete booking!"  # Debugging log
          redirect_to branch_ground_slots_path(@branch, @ground), alert: "Failed to cancel booking."
        end
      end
      
    
end      