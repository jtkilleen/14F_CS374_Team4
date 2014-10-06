require 'csv'

get '/' do
	@var = "jonathan"
	erb :home
end

get '/ice' do
	@var = "thing"
	erb :ice
end

get '/login' do
	erb :login
end

post '/login' do
	@username = this.username
	@password = this.password
	@error = ""
	users = User.all(:where => password == @password)
	if(users.nil?)
		@error = "Error: Wrong credentials"
		redirect '/login'
	else
		redirect '/'
	end
end