class UsersController < ApplicationController

  get '/' do 
    if logged_in? 
      redirect '/tweets' 
    end 
    erb :'users/index'
  end 

  get '/login' do 
    if logged_in? 
      redirect '/tweets'
    end 
    erb :'users/login' 
  end 

  post '/login' do 
    user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
      session[:user_id] = user.id
			redirect "/tweets"
		else 
			redirect "/signup"
		end 
  end 

  get '/signup' do 
    if !logged_in? 
      erb :'users/signup'
    else 
      redirect '/tweets'
    end 
  end 

  post '/signup' do 
    if params[:username].empty? || params[:password].empty? || params[:email].empty? 
      redirect '/signup'
    end 
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    user.slug 
    session[:user_id] = user.id 
    redirect '/tweets'
  end 

  get '/logout' do 
    session.clear 
    redirect '/login'
  end 

end
