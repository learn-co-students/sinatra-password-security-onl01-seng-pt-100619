class User < ActiveRecord::Base
  #validation that user has entered password upon signup \|
  has_secure_password
	
end