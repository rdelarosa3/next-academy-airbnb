class ReservationMailer < ApplicationMailer

	def booking_email(user,reservation,host) # arguments passed from braintree controller
      @reservation = reservation
      @user = user
      @host = host
      mail(to: @user.email, subject: "Reservation Confirmation")
	end
end
