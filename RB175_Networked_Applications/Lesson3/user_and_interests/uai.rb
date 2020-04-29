require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'
# redirect home to an all users page

before do
  @all_users = YAML.load_file('data/users.yaml')
end

get '/' do
  redirect to '/allusers'
end

get '/allusers' do
  
  @names = @all_users.keys.map do |name|
    "<li><a href='/user/#{name}'>#{name}</a></li>"
  end.join

  erb :all_users
end

get '/user/:name' do
  @name = params[:name]
  @email = @all_users[@name.to_sym][:email]
  @interests = @all_users[@name.to_sym][:interests].map do |interest|
    "<li>#{interest}</li>"
  end.join
  
  erb :single_user
end

