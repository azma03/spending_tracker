require("sinatra")
require("sinatra/contrib/all")
require_relative('controllers/tags_controller')
require_relative('controllers/merchants_controller')
require_relative('controllers/users_controller')
require_relative('controllers/currencies_controller')

get '/' do
  erb(:index)
end
