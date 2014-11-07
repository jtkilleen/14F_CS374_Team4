require 'mongoid'
require './models/Section.rb'

def classSearch(crn)
	section = Section.where(crn: crn).first
	puts section
	if section.nil?
		return nil
	end
	return section
end

