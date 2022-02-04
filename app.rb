#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
		# user_name, phone, date_time
		@username = params[:username]
		@date_time = params[:date_time]
	  
		@title = "Thank you!"
		@message = "Уважаемый #{@username}, мы ждём вас #{@date_time}"
	  
		erb :visit
	  end