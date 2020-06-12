require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, enigma
  end
  
  get '/' do
    erb :home
  end
  
  def helpers do
    def is_logged_in?
      !!current_user
    end
    
    def current_user
      User.find_by(id: session[:user_id])
    end
    
    def require_login
      unless is_logged_in?
      redirect "/login"
    end
    end
    
  end

end
