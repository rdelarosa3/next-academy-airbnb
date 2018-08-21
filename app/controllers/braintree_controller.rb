class BraintreeController < ApplicationController
 
  def new
  @reservation = Reservation.find(params[:id])
  @client_token = Braintree::ClientToken.generate
  end

	def checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => params["checkout_form"]["amount"].to_s, #params passed from checkout form 
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	booking_id = params["checkout_form"]["reservation"] #params passed from checkout form 
	  	booking = Reservation.find(booking_id)
	  	booking.status = 1 #change status to booked after payment
	  	booking.save
	  	host = booking.listing.user.id
	  	# ReservationMailer.booking_email(current_user,booking, host).deliver
		# ReservationJob.perform_later(current_user,booking, host) # Job to multithread system
	    redirect_to reservation_url(booking_id), :flash => { :notice => "Transaction successful!" }# back to reservation page
	  else
	    redirect_to :root, :flash => { :notice => "Transaction failed. Please try again." }
	  end
	end

end

