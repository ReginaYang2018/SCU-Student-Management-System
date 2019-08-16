require 'data_mapper'
require 'dm-core'
require 'dm-migrations'

class StudentInformation
  include DataMapper::Resource
  property :fname, String
  property :lname, String
  property :birthday, Date
  property :address, String
  property :sid, String
  property :hobby, String
  property :id, Serial
end

configure do
  enable :sessions
  set :username, 'Mengyao'
  set :password, 'Yang'
end

DataMapper.finalize

get '/students' do
    if session[:admin]
    @student = StudentInformation.all
    erb :students
  else
    erb :askforlogin
  end
end

get '/students/new' do
  halt(401,'Not Authorized') unless session[:admin]
  @student = StudentInformation.new
  erb :new_student
end

get '/students/:id' do
  @student = StudentInformation.get(params[:id])
  erb :show_student
end


get '/students/:id/edit' do
  @student = StudentInformation.get(params[:id])
  erb :edit_student
end

post '/students' do  
  student = StudentInformation.create params[:student]
  puts params[:student]
  redirect to("/students/#{student.id}")
end




put '/students/:id' do
  student = StudentInformation.get(params[:id])
  student.update(params[:student])
  redirect to("/students/#{student.id}")
end

delete '/students/:id' do
  StudentInformation.get(params[:id]).destroy
  redirect to('/students')
end
