class UsersController < ApplicationController
  
  get '/signup' do
    erb : '/users/signup'
  end
  
  post '/signup' do
        user = User.new(params[:user])
        if user.password.empty? || user.email.empty?
           @error = "all feilds are required*" 
           erb :'users/signup'
        elsif 
            User.find_by(email: user.email)
            @error = "account already exists, try to login instead*"
            erb :'users/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect "/users/#{user.id}/index"
        end
    end

end
