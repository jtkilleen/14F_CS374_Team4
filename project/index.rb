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

	# def moveSection(crn, time)
	# 	classSearch(crn)
	# end

	# def randClass
	# 	r = rand(4-1) + 1
	# 	if r == 1 then "Freshman" elsif r==2 then "Sophomore" elsif r==3 then "Junior" else "Senior" end
	# end

	# def randMajor
	# 	r = rand(4-1) + 1
	# 	if r == 1 then "Computer Science" elsif r==2 then "English" elsif r==3 then "Engineering" else "Underwater Basket Weaving" end
	# end

	get '/' do
		@buildings = Room.distinct(:building)
		erb :welcome
	end

	get '/student/:crn' do
		banner = params[:crn]
		stud = Student.where(acuid: banner).first
		if stud.nil? then raise 404 end
		@mwfsections = stud.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[MWF]/}
		@trsections = stud.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[TR]/}
		@student = stud
		erb :student
	end

	get '/building/:building' do
		@buildingName = params[:building]
		if Room.where(building: @buildingName).first.nil? then status 404 end 
		buildingsections = []
		mwfsect = []
		mwfcourse = []
		trsect = []
		trcourse = []
		teacherMWFList = []
		teacherTRList = []
		buildingrooms = Room.where(building: @buildingName).sort_by{|x| x.roomnumber.to_i}
		buildingrooms.each do |r|
			buildingsections << r.sections.sort_by{|x| x.beginTime.to_i}
		end
		@rooms = buildingrooms.to_json  ### Turn to JSON so it can be used in our javascript ###
		buildingrooms.each do |r|
			mwfsect << r.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[MWF]/}
			trsect << r.sections.sort_by{|x| x.beginTime.to_i}.select{|y| y.day=~ /[TR]/}
		end
		mwfsect.each do |m|
			mwfcourse << m.map{|n| n.courses[0]}
			teacherMWFList << m.map{|n| n.teachers[0]}
		end
		trsect.each do |t|
			trcourse << t.map{|n| n.courses[0]}
			teacherTRList << t.map{|n| n.teachers[0]}
		end
		@mwfsections = mwfsect.to_json
		@trsections = trsect.to_json
		@mwfcourses = mwfcourse.to_json
		@trcourses = trcourse.to_json
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

	not_found do
		status 404
		erb :oops
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
		room = Room.where(building: params[:building], roomnumber: params[:room]).first
		time = params[:time].gsub(':','')
		puts "the time is #{time}"
		canMove = true
		puts "#{room.roomnumber}"
		days = section.day.split("")
		room.sections.each do |s|
			dayCheck = false
			days.each do |d|
				if s.day.include? d
					dayCheck = true
				end
			end
			if s.beginTime == time  && dayCheck
				canMove = false
			end
		end

		if canMove
			students = section.students
			students.each do |s|
				s.sections.each do |sect|
					dayCheck = false
					days.each do |d|
						if sect.day.include? d
							dayCheck = true
						end
					end
					if sect.beginTime == time and sect != section and dayCheck
						conflictExists = false
						@conflicts.each do |c|
							if c[:banner] == s.acuid
								conflictExists = true
							end
						end
						if conflictExists then next end
						@conflicts << Hash[firstName: s.firstName, lastName: s.lastName, banner: s.acuid, classification: s.classification]
					end
				end
			end
		end
		@conflicts.sort_by!{|s| s[:classification]}.reverse!
		Hash[canMove: canMove, conflicts: @conflicts].to_json
	end
end