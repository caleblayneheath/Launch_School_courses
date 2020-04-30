require 'yaml'

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'

before do
  @all_users = YAML.load_file('data/users.yaml')
end

helpers do
  def count_users
    @all_users.keys.size
  end

  def count_interests
    results = []
    
    @all_users.each_value do |fields|
     results << fields[:interests]
    end

    results.flatten.uniq.size
  end
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
  @name = params[:name].to_sym
  @email = @all_users[@name][:email]
  @interests = @all_users[@name][:interests].map do |interest|
    "<li>#{interest}</li>"
  end.join
  
  other_users = @all_users.reject { |key, _| key == params[:name].to_sym }.keys
  @user_links = other_users.map do |user|
    link = "/user/#{user}"
    "<li><a href=#{link}>#{user}</a></li>"
  end.join

  erb :single_user
end

get "/course/:teacher/:student" do |teacher, student|
  @teacher_name = params[:teacher]
  @student_name = params[:student]

  erb :teacher_student
end

not_found do; "woops"; end
