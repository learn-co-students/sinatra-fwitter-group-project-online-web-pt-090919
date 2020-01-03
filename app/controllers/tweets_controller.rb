class TweetsController < ApplicationController

     get '/tweets' do 
          @tweets = Tweet.all
          if is_logged_in?
               erb :"/tweets/index"
          else
               redirect "/login"
          end
     end

end
