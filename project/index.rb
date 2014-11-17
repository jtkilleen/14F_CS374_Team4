require 'sinatra'
require_relative 'login.rb'
require_relative 'classSearch.rb'
require_relative 'populate.rb'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

class Application < Sinatra::Base
	enable :sessions

	configure do 
	 	Mongoid.load!("./mongoid.yml")
	 	Mongoid.purge!
	 	populate("./Student_Data.csv")
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
		if r == 1 then "Computer Science" elsif r==2 then "English" elsif r==3 then "Engineering" else "Underwater Basket Weaving" end
	end

	get '/' do
		puts session[:username]
		puts
		buildingsections = []
		mwfsect = []
		trsect = []
		teacherMWFList = []
		teacherTRList = []
		buildingrooms = Room.where(building: "MBB").sort_by{|x| x.roomnumber.to_i}
		buildingrooms.each do |r|
			buildingsections << r.sections.sort_by{|x| x.beginTime.to_i}
		end
		@rooms = buildingrooms.to_json  ### Turn to JSON so it can be used in our javascript ###
		buildingrooms.each do |r|
			mwfsect << r.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[MWF]/}
			trsect << r.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[TR]/}
		end
		mwfsect.each do |m|
			teacherMWFList << m.map{|n| n.teachers[0]}
		end
		trsect.each do |t|
			teacherTRList << t.map{|n| n.teachers[0]}
		end
		@mwfsections = mwfsect.to_json
		@trsections = trsect.to_json
		@sections = buildingsections.to_json
		@teachersMWF = teacherMWFList.to_json
		@teachersTR = teacherTRList.to_json
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
					beginTime: "8:00",
					endTime: "8:50",
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
		puts "#{params[:text]}"
		@conflicts = []
		section = Section.where(crn: params[:text]).first
		teacher = section.teachers.first
		room = Room.where(building: "MBB", roomnumber: params[:room]).first
		time = params[:time].gsub(':','')
		puts "the time is #{time}"
		canMove = true
		puts "#{room.roomnumber}"
		room.sections.each do |s|
			if s.beginTime == time
				canMove = false
			end
		end

		# teacher.sections.each do |t|
		# 	if t.beginTime == time
		# 		canMove = false
		# 	end
		# end

		if canMove
			students = section.students
			students.each do |s|
				s.sections.each do |sect|
					if sect.beginTime == time and sect != section
						@conflicts << Hash[firstName: s.firstName, lastName: s.lastName, banner: s.acuid, classification: s.classification]
					end
				end
			end
		end
		@conflicts.sort_by!{|s| s[:classification]}.reverse!
		Hash[canMove: canMove, conflicts: @conflicts].to_json
	end
end