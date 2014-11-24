require 'mongoid'
require 'csv'
require_relative '../../populate.rb'
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
	#populate('../../Student_Data.csv')
end

After do
	#Mongoid.purge!
end