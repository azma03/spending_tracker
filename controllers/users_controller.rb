require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/user.rb")
also_reload("../models/*")

set :show_exceptions, :after_handler

error 400..510  do
  erb(:"users/error")
end

get '/users' do
  @users = User.all()
  # binding.pry
  erb(:"users/index")
end

get '/users/new' do
  erb(:"users/new")
end

post '/users' do
  @user = User.new(params)
  @user.save
  erb(:"users/create")
end

post '/users/:id/delete' do
  @user = User.find(params[:id])
  @user.delete()
  redirect '/users'
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb(:"users/edit")
end

post '/users/:id' do
  @user = User.new(params)
  @user.update()
  redirect '/users'
end

get '/users/:id' do
  @user = User.find(params['id'].to_i)
  erb( :"users/show" )
end
