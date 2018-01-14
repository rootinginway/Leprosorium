#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
end

#before вызывается каждый раз при перезагрузке любой стр.
before do
	#инициализация БД
	init_db
end

#configure вызывается каждый раз при конфигурации приложения
# когда изменился код программы и перезагрузилась страница

configure do
		#инициализация БД
		init_db
		@db.execute 'CREATE TABLE IF NOT EXISTS "Posts"
		 (
		"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
		"created_date" DATE, 
		 "content" TEXT
		 )'
end


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
	erb :new
end

post '/new' do
 content = params[:content]

 erb "You typed #{content} here."

 	if content.length <=0
 		@error = 'Type text'
 		return erb :new
	end
end
