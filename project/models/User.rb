class User
	include Mongoid::Document
	
	field :username, type: String
	field :password, type: String
	field :firstName, type: String
	field :lastName, type: String
end