class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :valid_dates?
  validate :check_overlapping_dates
  enum status: ["Available","Booked","Pending"]


  # sum of nights booked
  def nights
  	(self.end_date - self.start_date).to_i
  end

  # total price for reservation
  def total
  	self.listing.price * nights
  end

  # test if dates overlap prior to saving reservation
  def check_overlapping_dates
  	overlapping_dates = 
  		listing.reservations.map do |scheduled|
  		if overlap?(self,scheduled)
        if self == scheduled #to allow update of reservation after payment is complete
          return false
        else
  			true
        end
  		end
  	end
  	.include?(true)

  	if overlapping_dates
  		errors.add(:overlapping_dates, "Pick a new Date")
  	end
  end

  # test dates against each other to check overlap
  def overlap?(x,y)
 	if self.listing.reservations.count != 0
 	(x.start_date - y.end_date) * (y.start_date - x.end_date)  > 0	
  	end
  end


  # check if end date if after start date
  def valid_dates?
    if end_date < start_date
      errors.add(:valid_dates?, "must be after start date")
    end
  end

  def self.on_dates(date_start,date_end)
    Reservation.where("start_date > ? AND end_date <?", date_start,date_end)
  end

  
end
