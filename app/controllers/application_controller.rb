require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :"/index"
  end

  get "/signup" do 
    erb :"/registrations/signup"
  end

  post "/registrations" do 
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user 
      session[:username] = @user.username
      redirect '/user/home'
    end
  end

  get '/login' do 
    erb :"/sessions/login"
  end

  # HELPERS 

  def is_logged_in?
    !!session[:username]
  end

  def current_user
    User.find(session[:username])
  end

end
