require 'csv'
#require 'mongoid'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

def populate(file)
	i = 2
	CSV.foreach(file, headers:true, :encoding => 'windows-1251:utf-8') do |row|
		begin
			if row['Bldg Code1'] != "MBB"
				next
			end
			##### STUDENT ATTRIBUTES #####
			banner = row['Banner ID']
			puts "#{banner}" if i == 1872
			classification = row['Class Code']
			firstName = row['First Name']
			lastName = row['Last Name']
			major = row['Major Code1']
			##### TEACHER ATTRIBUTES #####
			teacherId = row['Instructor ID']
			teacherFirstName = row['Instructor Name'].split(',')[1]
			teacherLastName = row['Instructor Name'].split(',')[0]
			##### ROOM ATTRIBUTES #####
			building = row['Bldg Code1']
			roomnumber = row['Room Code1']
			##### COURSE ATTRIBUTES #####
			courseName = row['Subject Code'] + row['Course Number']
			courseDepartment = row['Subject Code']
			##### SECTION/COURSE ATTRIBUTES #####
			crn = row['CRN']
			beginTime = if row['Begin Time 1'][0] == "0" then row['Begin Time 1'][1..-1] else row['Begin Time 1'] end
			endTime = row['End Time1']
			days = "#{row['Monday Ind1']}#{row['Tuesday Ind1']}#{row['Wednesday Ind1']}#{row['Thursday Ind1']}#{row['Friday Ind1']}"
			##### DATABASE STUFF #####
			s = Student.where(acuid: banner).first
			c = Course.where(name: courseName).first
			sect = Section.where(crn: crn).first
			t = Teacher.where(acuid: teacherId).first
			r = Room.where(building: building, roomnumber: roomnumber).first
			numberClass = "0"
			if classification == "FR"
				numberClass = "1"
			elsif classification == "SO"
				numberClass = "2"
			elsif classification == "JR"
				numberClass = "3"
			elsif classification == "SR"
				numberClass = "4"
			end

			if s.nil?
				student = Student.new(
					acuid: banner,
					classification: numberClass,
					major: major,
					firstName: firstName,
					lastName: lastName
					)
				student.save
			end

			if c.nil?
				course = Course.new(
					name: courseName,
					department: courseDepartment
					)
				course.save
			end

			if sect.nil?
				section = Section.new(
					crn: crn,
					beginTime: beginTime,
					endTime: endTime,
					day: days
					)
				section.save
			end

			if t.nil?
				teacher = Teacher.new(
					acuid: teacherId,
					firstName: teacherFirstName,
					lastName: teacherLastName
					)
				teacher.save
			end

			if r.nil?
				build = Room.new(
					building: building,
					roomnumber: roomnumber
					)
				build.save
			end
			enrolled = row['Reg STS Code'] 
			if (enrolled == 'RW' or enrolled == 'RE')
				student = Student.where(acuid: banner).first
				section = Section.where(crn: crn).first
				section.students << student
				student.sections << section
			end
			section = Section.where(crn: crn).first
			course = Course.where(name: courseName).first
			
			if !section.courses.include? course
				section.courses << course
			end

			if !course.sections.include? section
				course.sections << section
			end

			teacher = Teacher.where(acuid: teacherId).first
			if !section.teachers.include? teacher
				section.teachers << teacher
			end

			if !teacher.sections.include? section
				teacher.sections << section
			end

			room = Room.where(building: building, roomnumber: roomnumber).first
			if !room.sections.include? section
				room.sections << section
			end

			if section.room != room
				section.room = room
			end
		rescue
			next
		end
		i=i+1
		puts i
		if i == 1000
			break
		end
	end
end

#populate("./Student_Data.csv")