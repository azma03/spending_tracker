require("sinatra")
require("sinatra/contrib/all")
require_relative('controllers/tags_controller')

get '/' do
  erb(:index)
end
