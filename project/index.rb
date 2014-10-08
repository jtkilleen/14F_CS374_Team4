require 'csv'

get '/' do
	@var = "jonathan"
	erb :home
end

get '/login' do
	erb :login
end