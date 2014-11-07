require 'mongoid'
require './models/User.rb'

def loginUser(username, password)
	user = findUser(username)
	if user.nil?
		return false
	end
	if password == user.password
		return true
	end
	return false
end

def findUser(username)
	user = User.where(username: username)
	if user.empty?
		return nil
	end
	return user.first
end