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

	def randClass
		r = rand(4-1) + 1
		if r == 1 then "Freshman" elsif r==2 then "Sophomore" elsif r==3 then "Junior" else "Senior" end
	end

	def randMajor
		r = rand(4-1) + 1
		if r == 1 then "Compuer Science" elsif r==2 then "English" elsif r==3 then "Engineering" else "Underwater Basket Weaving" end
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
					hours: "8:00-8:50",
					day: "MWF" )
			section.save
			student = Student.new(
				acuid: "jtk#{i}b",
				firstName: "asdf#{i}",
				lastName: "fdsa#{i}",
				classification: randClass,
				major: randMajor)
			student.save
			student.sections << section
			section.students << student
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

	post '/classmover' do
		section = Section.where(crn: params[:name]).first
		puts section
		"#{section[:name]}"
	end
end