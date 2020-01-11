require './config/environment'
# require "./app/models/user"
require 'pry'

class ApplicationController < Sinatra::Base
  # ApplicationController
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # ejnable app to use `sessions` keyword to access session hash
    enable :sessions
    set :session_secret, "password_security"
  end
  
  # render view of Homepage
  get '/' do
    erb :'index' 
  end
  
  # HELPERS 
  helpers do
    def logged_in?
      !!session[:user_id]
    end
  
    def current_user
      User.find(session[:user_id])
    end
  end
end
