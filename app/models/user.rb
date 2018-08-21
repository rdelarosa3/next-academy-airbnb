class User < ApplicationRecord
	
	include Clearance::User
	has_many :authentications, dependent: :destroy
	has_many :listings
	has_many :reservations
	enum role: ["member","host", "admin"]
	mount_uploader :avatar, AvatarUploader
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :birthdate, presence: true
	validates :email, presence: true


	def self.create_with_auth_and_hash(authentication, auth_hash)
	user = self.create!(
	 # name: auth_hash["info"]["name"],
	 email: auth_hash["info"]["email"],
	 password: SecureRandom.hex(10),
	 first_name: auth_hash["info"]["first_name"],
     last_name: auth_hash["info"]["last_name"], 
     birthdate: Date.new(1970,1,1)
	)
	user.authentications << authentication
	return user
	end

	# grab google to access google for user data
	def google_token
	x = self.authentications.find_by(provider: 'google_oauth2')
	return x.token unless x.nil?
	end
end
