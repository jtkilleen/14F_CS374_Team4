require 'csv'

get '/' do
	@var = "jonathan"
	erb :home
end

get '/tyler' do
	"Tyler sucks"
end