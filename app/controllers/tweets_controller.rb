class TweetsController < ApplicationController

     get '/tweets' do 
          if is_logged_in?
               @tweets = Tweet.all
               erb :"/tweets/index"
          else
               redirect to "/login"
          end
     end

end
