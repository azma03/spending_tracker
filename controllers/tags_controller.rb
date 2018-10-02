require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/tag.rb")
also_reload("../models/*")

# set :show_exceptions, :after_handler

# not_found do
#   erb(:"tags/error")
# end
#
# error 500 do
#   "The tag alredy exists"
# end

# error 400..510  do
#   erb(:"tags/error")
# end

# error do
#   'Sorry there was an error - ' + env['sinatra.error'].message
# end

get '/tags' do
  @tags = Tag.all()
  # binding.pry
  erb(:"tags/index")
end

get '/tags/new' do
  erb(:"tags/new")
end

post '/tags' do
  @tag = Tag.new(params)
  @tag.save
  erb(:"tags/create")
end

post '/tags/:id/delete' do
  @tag = Tag.find(params[:id])
  @tag.delete()
  redirect '/tags'
end

get '/tags/:id/edit' do
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end

post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.update()
  redirect '/tags'
end

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
  erb( :"tags/show" )
end
