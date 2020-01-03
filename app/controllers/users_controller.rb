class UsersController < ApplicationController

     get '/user/home' do 
          if is_logged_in?
               erb :"/users/home"
          else
               redirect "/login"
          end
     end

end
