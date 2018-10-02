require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/transaction.rb")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/currency.rb")
also_reload("../models/*")

get '/transactions' do
  @transactions = Transaction.all()
  @total_amount = Transaction.get_total_spendings()
  # binding.pry
  erb(:"transactions/index")
end

get '/transactions/new' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  @currencies = Currency.all()
  erb(:"transactions/new")
end

post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save
  erb(:"transactions/create")
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect '/transactions'
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  @tags = Tag.all()
  @merchants = Merchant.all()
  @currencies = Currency.all()
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.update()
  redirect '/transactions'
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'].to_i)
  erb( :"transactions/show" )
end
