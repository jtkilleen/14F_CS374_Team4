require 'csv'
require 'sinatra'
require_relative 'login.rb'
require_relative 'classSearch.rb'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

class Application < Sinatra::Base
	enable :sessions

	configure do 
	 	Mongoid.load!("./mongoid.yml")
	 	#Mongoid.purge!
	end

	# def loginUser(username, password)
	# 	user = User.where(username: username).first
	# 	if password == user.password
	# 		return true
	# 	end
	# 	return false
	# end

	# def classSearch(crn)
	# 	section = Section.where(crn: crn).first
	# 	puts section
	# 	if section.nil?
	# 		return nil
	# 	end
	# 	return section
	# end

	def moveSection(crn, time)
		classSearch(crn)
	end

	get '/' do
		puts session[:username]
		puts
		@var = "jonathan"
		erb :home
	end

	get '/createUser' do
		thing = User.new(
			username: "jeff@jeff.com",
			password: "jeff")
		thing.save
		for i in 1..10
			section = Section.new(
					crn: "#{i}",
					hours: "8",
					day: "MWF" )
			section.save
		end
		"hello"
	end

	get '/classSearch' do
		section = classSearch("4")
		"#{section.crn}"
	end

	get '/clearDB' do
		Mongoid.purge!
	end

	get '/login' do
		@errors = ""
		erb :login
	end

	post '/login' do
		email = params[:email]
		password = params[:password]
		if loginUser(email, password)
			session[:username] = email
			redirect '/'
		end
		@errors = "Error, could not login"
		erb :login
	end
end