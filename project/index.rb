require 'csv'

enable :sessions

get '/' do
	puts session[:username]
	puts
	@var = "jonathan"
	erb :home
end


get '/login' do
	@errors = ""
	erb :login
end

post '/login' do
	email = params[:email]
	session[:username] = params[:email]
	if email == "jeff@jeff.com"
		redirect '/'
	end
	session[:username] =
	@errors = "Error, could not login"
	erb :login
end