class BookingMailer < ApplicationMailer
    default from: 'notifications@yourapp.com'  # Set sender email
  
    def booking_confirmation(user, booking)
      @user = user
      @booking = booking
      puts "📩 Sending email to: #{@user.email}"  # Debugging
      mail(to: @user.email, subject: "Your Slot Booking Confirmation")
    end
  end
  