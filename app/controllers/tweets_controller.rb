class TweetsController < ApplicationController
   get '/tweets' do
    @users = User.all
    if Helpers.logged_in?(session)
      erb :'tweets/index'
    else
      redirect '/login'
    end
    end
    
    get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => Helpers.current_user(session).id)
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end
  
  get '/tweets/:id' do
    if Helpers.logged_in?(session)
       @tweet = Tweet.find_by_id(params[:id])
       erb:'tweets/show'
     else
       redirect to '/login'
     end
  end
  
  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
       @tweet = Tweet.find_by_id(params[:id])
       erb :'tweets/edit'
     else
       redirect to '/login'
     end
   end
   
   patch '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.content = params[:content]
        @tweet.user_id = Helpers.current_user(session).id
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/tweets/:id/delete' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == Helpers.current_user(session).id
        @tweet.delete
        redirect to '/tweets'
      end
end
