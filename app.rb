require "bundler/setup"
Bundler.require
require "sinatra/reloader" if development?
require_relative "utils/date.rb"

enable :sessions

puts "Loading models.rb..."
require "./models.rb"
puts "models.rb loaded."

def logged_in?
  !!session[:user_id]
end

get '/' do
    if logged_in?
        @posts = Post.all
        erb :index
    else
        redirect "/signup"
    end
end

get "/signup" do
    erb :signup
end

post "/signup" do
    user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password])
    if user.persisted?
        session[:user] = user.id
        redirect "/login"
    else
        redirect "/signup"
    end
end

get "/login" do
    erb :login
end

post "/login" do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        redirect "/index"
    else
        redirect "/login"
    end
end