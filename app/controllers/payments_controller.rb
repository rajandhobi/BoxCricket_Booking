
class PaymentsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @booking = Booking.find(params[:booking_id])
      @slot = @booking.slot
    end
  
    def create
      @booking = Booking.find(params[:booking_id])
  
      # Call Stripe API for actual payment processing
      if process_payment
        # Create the Payment record
        payment = Payment.create!(
          booking: @booking,
          amount: (@booking.slot.price * 100).to_i,  # Convert price to cents (adjust if necessary)
          status: "paid", # You can also use 'pending' or other statuses if needed
          transaction_id: @charge.id  # Store the Stripe charge ID as the transaction ID
        )
  
        @booking.update(status: "booked")

        @booking.slot.update(status: "booked")  # Ensure Slot model has a 'status' column

        redirect_to branch_ground_path(@booking.slot.ground.branch, @booking.slot.ground), notice: "Payment successful! Your slot is confirmed."
      else
        redirect_to new_payment_path(booking_id: @booking.id), alert: "Payment failed. Please try again."
      end
    end
  
    private
  
    def process_payment
      begin
        # Create Stripe customer
        customer = Stripe::Customer.create({
          email: current_user.email,
          source: params[:stripeToken], # Card Token from frontend
        })
  
        # Create the Stripe charge
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: (@booking.slot.price * 100).to_i,  # Convert price to cents
          currency: 'inr',
          description: "Payment for Booking ID: #{@booking.id}",
        })
  
        # Store Stripe response in instance variables
        @charge = charge
        @customer = customer
  
        charge.paid  # Returns true if payment is successful
      rescue Stripe::CardError => e
        flash[:alert] = e.message
        false
      end
    end
  end
  