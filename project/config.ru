require 'rubygems'
require 'bundler'
require 'sinatra'
Bundler.require

require File.expand_path '../index.rb', __FILE__

run Sinatra::Application
