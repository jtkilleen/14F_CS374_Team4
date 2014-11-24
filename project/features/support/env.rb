require 'capybara'
require 'capybara/cucumber'
require 'mongoid'
require 'csv'

require_relative "../../index"

Mongoid.load! "mongoid.yml"

Capybara.default_driver = :selenium
Capybara.app = Application