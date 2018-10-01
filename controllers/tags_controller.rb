require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/tag.rb")
also_reload("../models/*")

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

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
  erb( :"tags/show" )
end
