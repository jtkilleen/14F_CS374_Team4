require 'rubygems'
require 'bundler'
require 'sinatra'
require 'mongoid'
Bundler.require
require './index'

class Application
	configure do
		Mongoid.load! 'mongoid.yml'
	end
end

run Application.new
