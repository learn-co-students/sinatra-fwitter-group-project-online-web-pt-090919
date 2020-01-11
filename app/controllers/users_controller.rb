class UsersController < ApplicationController
  # display sign up form
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :"users/create_user"
  end
  
  # process the form submission
  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    
    # user has has_secure_password
    # won't be saved to the db unless our user filled out the password field
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else #won't be saved if user can't be persisted
      redirect '/signup'
    end
  end
  
  get '/login' do
    if logged_in?
      # erb :"user/tweets"
      redirect '/tweets'
    end
    erb :"users/login"
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    
    # authenticate turns string into hashed ver and compares with user's stored hashed password in db 
    if user && user.authenticate(params[:password])
      session[:user_id]  = user.id
      redirect '/tweets'
    else
      # redirect '/login'
      erb :"users/login"
    end
  end
  
  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
    
  # Displays individual user's tweets
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug].to_s) #name in slug symbol
    # @user.tweets = []
    # Tweet.all.each do |tweet|
    #   @user.tweets << tweet if tweet.user_id == @user.id
    # end
    erb :'/users/show'
  end
end
