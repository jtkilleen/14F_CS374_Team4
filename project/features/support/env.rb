require 'capybara'
require 'capybara/cucumber'
require 'mongoid'

require_relative "../../index"

Mongoid.load! "mongoid.yml"

Capybara.app = Application