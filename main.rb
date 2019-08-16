#Main code which will show the working of whole application. StudentData Database is created for tables.
require 'sinatra'
require 'slim'
require 'sass'
require './student'
require './comment'

configure do
  enable :sessions
  set :username, 'Mengyao'
  set :password, 'Yang'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.db")
  DataMapper.auto_migrate!
end

configure :production do
  require 'data_mapper'
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  DataMapper.auto_migrate!
end

get('/styles.css'){ scss :styles }

get '/' do
    erb :home
end

get '/about' do
  @title = "SCU Student Information Management Website"
  erb :about
end

get '/contact' do
  erb :contact
end

get '/video' do
 @title = "Please see this video"
 erb :video
end

not_found do
  erb :not_found
end

get '/home' do
  erb :home
end

get '/login' do
  erb :login
end


post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/home')
  else
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/set/:name' do
  session[:name] = params[:name]
end

get '/get/hello' do
  "Hello #{session[:name]}"
end  
