require 'capybara'
require 'capybara/cucumber'
require 'mongoid'
require 'csv'

require_relative "../../index"

Mongoid.load! "mongoid.yml"

Capybara.current_driver = :selenium
Capybara.app = Application