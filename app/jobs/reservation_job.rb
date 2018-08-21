class ReservationJob < ApplicationJob
  queue_as :default

  # ASYNC for emails
  def perform(user,reservation,host)
  	ReservationMailer.booking_email(user,reservation,host).deliver
  end
end
