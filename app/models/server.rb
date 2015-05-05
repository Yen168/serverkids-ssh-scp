class Server < ActiveRecord::Base

	#attr_accessible :host, :name, :password_digest, :user, :password, :password_confirmation

	before_save { self.name = name.upcase }

	has_secure_password

	validates :name, presence: true
	validates :host, presence: true
	validates :user, presence: true
	validates :password, presence: true
	validates :password_confirmation, presence: true

	




end
