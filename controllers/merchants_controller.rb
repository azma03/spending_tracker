require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/merchant.rb")
also_reload("../models/*")

set :show_exceptions, :after_handler

error 400..510  do
  erb(:"merchants/error")
end

get '/merchants' do
  @merchants = Merchant.all()
  # binding.pry
  erb(:"merchants/index")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  @merchant = Merchant.new(params)
  @merchant.save
  erb(:"merchants/create")
end

post '/merchants/:id/delete' do
  @merchant = Merchant.find(params[:id])
  @merchant.delete()
  redirect '/merchants'
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end

post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update()
  redirect '/merchants'
end

get '/merchants/:id' do
  @merchant = Merchant.find(params['id'].to_i)
  erb( :"merchants/show" )
end
