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
  @color = params[:color]
	# хеш для вывода ошибки
  hh = {
	:username => 'Введите имя',
	:date_time => 'Введите дату и время'}
	# для каждой пары ключ-значение
  hh.each do |key, value|
	#если параметр пуст
	if params[key] == ''

	#еременной error рисвоить value из хеша 
	#а value из hh это сообщение об ощибке
	#т.е. переменной error рисвоить сообщение об оштбке
	@error = hh[key]
	# вернуть представление
		return erb :visit
	end
  end

  if @username == ''
	@error = 'Введите имя'
	return erb :visit
  end

  @title = "Thank you!"
  @message = "Уважаемый #{@username}, мы ждём вас #{@date_time}, ваш барбер #{@barber}, цвет: #{@color}"

  f = File.open 'users.txt', 'a'
  f.write "User: #{@username}, date and time: #{@date_time}, barber: #{@barber}, color: #{@color}"
  f.close

  erb :visit
end

# contacts
get '/cont' do
  erb :cont
end


post '/cont' do

  @email = params[:email]

  # валидаци без хеша

  if @email == ''
	@error = 'Введите @mail'
	return erb :cont
  end


  @answer = "#{@email}, мы свяжемся с вами"

  f = File.open 'contacts.txt', 'a'
  f.write "Ответить: #{@email}"
  f.close

  erb :cont
end
