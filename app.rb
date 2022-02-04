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
	@barber = params[:barber]
		
	@title = "Thank you!"
	@message = "Уважаемый #{@username}, мы ждём вас #{@date_time}, ваш барбер #{@barber}"
	  
	f = File.open 'users.txt', 'a'
  	f.write "User: #{@username}, date and time: #{@date_time}, barber: #{@barber}"
  	f.close

	erb :visit
end

=begin
get '/cont' do
  erb :cont
end


post '/cont' do
	
	@email = params[:email]
	@floatingTextarea = params[:floatingTextarea]
  
    @otvet = "#{@email}, мы свяжемся с вами"

	f = File.open 'contacts.txt', 'a'
	  f.write "Ответить: #{@email}"
	  f.close

	erb :cont
  end

=end
