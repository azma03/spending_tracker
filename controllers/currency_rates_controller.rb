require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/currency.rb")
require_relative("../models/currency_rate.rb")
also_reload("../models/*")

# set :show_exceptions, :after_handler

# error 400..510  do
#   erb(:"currencies/error")
# end

get '/currency_rates' do
  @currency_rates = CurrencyRate.all()
  # binding.pry
  erb(:"currency_rates/index")
end

get '/currency_rates/new' do
  @currencies = Currency.all()
  erb(:"currency_rates/new")
end

post '/currency_rates' do
  @currency_rate = CurrencyRate.new(params)
  @currency_rate.save
  erb(:"currency_rates/create")
end

post '/currency_rates/:id/delete' do
  @currency_rate = CurrencyRate.find(params[:id])
  @currency_rate.delete()
  redirect '/currency_rates'
end

get '/currency_rates/:id/edit' do
  @currency_rate = CurrencyRate.find(params[:id])
  @currencies = Currency.all()
  erb(:"currency_rates/edit")
end

post '/currency_rates/:id' do
  @currency_rate = CurrencyRate.new(params)
  @currency_rate.update()
  redirect '/currency_rates'
end

get '/currency_rates/:id' do
  @currency_rate = CurrencyRate.find(params['id'].to_i)
  erb( :"currency_rates/show" )
end
