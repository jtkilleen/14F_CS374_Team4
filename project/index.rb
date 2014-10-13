require 'csv'

get '/' do
	@var = "Jonathan Nix"
	erb :home
end

get '/jonathan' do
	erb :jonathan
end