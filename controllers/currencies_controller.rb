require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/currency.rb")
also_reload("../models/*")

set :show_exceptions, :after_handler

error 400..510  do
  erb(:"currencies/error")
end

get '/currencies' do
  @currencies = Currency.all()
  # binding.pry
  erb(:"currencies/index")
end

get '/currencies/new' do
  erb(:"currencies/new")
end

post '/currencies' do
  @currency = Currency.new(params)
  @currency.save
  erb(:"currencies/create")
end

post '/currencies/:id/delete' do
  @currency = Currency.find(params[:id])
  @currency.delete()
  redirect '/currencies'
end

get '/currencies/:id/edit' do
  @currency = Currency.find(params[:id])
  erb(:"currencies/edit")
end

post '/currencies/:id' do
  @currency = Currency.new(params)
  @currency.update()
  redirect '/currencies'
end

get '/currencies/:id' do
  @currency = Currency.find(params['id'].to_i)
  erb( :"currencies/show" )
end
