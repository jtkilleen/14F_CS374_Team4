require 'mongoid'
Dir[File.dirname(__FILE__) + '../../models/*.rb'].each {|file| require file }

def randClass
	r = rand(4-1) + 1
	if r == 1 then "Freshman" elsif r==2 then "Sophomore" elsif r==3 then "Junior" else "Senior" end
end

def randMajor
	r = rand(4-1) + 1
	if r == 1 then "Computer Science" elsif r==2 then "English" elsif r==3 then "Engineering" else "Underwater Basket Weaving" end
end

Before do
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
	room = Room.new(
		building: "MBB",
		roomnumber: "314",
		occupancy: "30")
	room.save
	room2 = Room.new(
		building: "MBB",
		roomnumber: "318",
		occupancy: "30")
	room2.save
	sectionexample = Section.where(crn: "1").first
	sectionexample.room = room2
	room2.sections << sectionexample

	room3 = Room.new(
		building: "MBB",
		roomnumber: "316",
		occupancy: "30")
	room3.save
	sectionexample2 = Section.where(crn: "2").first
	sectionexample2.room = room3
	room3.sections << sectionexample2

end

After do
	Mongoid.purge!
end