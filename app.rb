require "bundler/setup"
Bundler.require
require "sinatra/reloader" if development?
require_relative "utils/date.rb"

enable :sessions

# puts "Loading models.rb..."
require "./models.rb"
# puts "models.rb loaded."

def logged_in?
  !!session[:user]
end

get '/' do
    if logged_in?
        @posts = Post.all
        puts "aaa"
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
        redirect "/"
    else
        redirect "/login"
    end
end

# get "/index" do
#     redirect "/index"
# end

post '/post-content' do
    @post = Post.create(content: params[:content], user_id: session[:user])
    redirect "/"
end

get "/posts/:id" do
    @post = Post.find_by(id: params[:id])
    if @post
        @comments = @post.comments
        erb  :comment
    end
end

post "/post-comment" do
    @comment = Comment.create(content: params[:content], post_id: params[:post_id], user_id: session[:user])
    
    redirect "/posts/#{params[:post_id]}"
end