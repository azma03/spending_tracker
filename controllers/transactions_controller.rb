require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/transaction.rb")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/currency.rb")
also_reload("../models/*")

# set :show_exceptions, :after_handler

# error 400..510  do
#   erb(:"transactions/error")
# end

get '/transactions' do
   # binding.pry
  # if params["clear_filters"] == "clear_filters"
  #   @transactions = Transaction.all()
  #   @total_amount = Transaction.get_total_spendings()
  #   erb(:"transactions/index")
  # else
@tags = Tag.all()
    if params["sort-by-time-select"] == "time_ASC"
      @transactions = Transaction.all_by_time_asc()
      @total_amount = Transaction.get_total_spendings()
    elsif params["sort-by-time-select"] == "time_DESC"
      @transactions = Transaction.all_by_time_desc()
      @total_amount = Transaction.get_total_spendings()
    else
      @transactions = Transaction.all()
      @total_amount = Transaction.get_total_spendings()
    end

    # tag filter
    # if params["tag-select"]
    #   # binding.pry
    #   @transactions = Transaction.find_all_by_tag(params["tag-select"].to_i)
    #   @total_amount = Transaction.get_total_spendings_by_tag(params["tag-select"].to_i)
    # else
    #   @transactions = Transaction.all()
    #   @total_amount = Transaction.get_total_spendings()
    # end
    # # @total_amount = Transaction.get_total_spendings()
    erb(:"transactions/index")
  # end
end

get '/transactions/by_tag' do
    @tags = Tag.all()
  if params["tag-select"]
    # binding.pry
    @transactions = Transaction.find_all_by_tag(params["tag-select"].to_i)
    @total_amount = Transaction.get_total_spendings_by_tag(params["tag-select"].to_i)
  else
    @transactions = Transaction.all()
    @total_amount = Transaction.get_total_spendings()
  end
  # @total_amount = Transaction.get_total_spendings()
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
