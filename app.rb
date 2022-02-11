#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
  erb :about
end

get '/visit' do
	erb :visit
end

# Создадим базу данных при инициализации приложения: подключаем базу данных SQL

def get_db
  return SQLite3::Database.new 'users.sqlite'
end
configure do
  # Подключение
  db = get_db
  # создаем таблицу, если нет
  db.execute 'CREATE TABLE IF NOT EXISTS Users 
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT, 
      "username" TEXT, 
      "datestamp" TEXT, 
      "barber" TEXT, 
      "color" TEXT
    )'
    db.close
end

post '/visit' do


#user_name, phone, date_time
  @username = params[:username]
  @date_time = params[:date_time]
  @barber = params[:barber]
  @color = params[:color]

	# Валидация / хеш для вывода ошибки
  hh = {
	:username => 'Введите имя',
	:date_time => 'Введите дату и время'}
	
  # для каждой пары ключ-значение
  hh.each do |key, value|

	#если параметр пуст
	  if params[key] == ''

	#еременной error рисвоить value из хеша 
	#а value из hh это сообщение об ощибке
	#т.е. переменной error рисвоить сообщение об ошибке

	@error = hh[key]

	# вернуть представление
		  return erb :visit
	  end
  end
  
  #Добавляем данные в базу данных
  db = get_db
  # добавим новую информацию в базу данных SQLite
  db.execute 'INSERT INTO
    Users
      (username, datestamp, barber, color) 
      VALUES (?, ?, ?, ?)', [@username, @date_time, @barber, @color]

  @title = "Thank you!"
  @message = "Уважаемый #{@username}, мы ждём вас #{@date_time}, ваш барбер #{@barber}, цвет: #{@color}"

  erb :visit

end


# contacts
get '/cont' do
  erb :cont
end


post '/cont' do

  db = SQLite3::Database.new 'cont.sqlite'

  @email = params[:email]

  # валидаци без хеша

  if @email == ''
	  @error = 'Введите @mail'
	  return erb :cont
  end
  
  @answer = "#{@email}, мы свяжемся с вами"

  db.execute "INSERT INTO Contacts (Email) VALUES ('#{@email}')"

  db.close

  erb :cont
end






 
=begin --- !? --- отправка почтовых сооющений --- !? ---
  
rescue => exception
  
end  Pony.mail(
    :to => "dinyakov.a@yandex.ru",
    :from => "dinyakov.a@yandex.ru",

    :via => :smtp,
    :via_options => { 
      :address              => 'smtp.yandex.ru', 
      :port                 => '25', 
      :enable_starttls_auto => true, 
      :user_name            => 'Антон Диняков', 
      :password             => '55244255896321', 
      :authentication       => :plain
    })
=end