class TweetsController < ApplicationController

  get '/tweets' do 
    if !logged_in?
      redirect '/login' 
    end 
    @user = current_user 
    @tweets = Tweet.all 
    erb :'tweets/index'
  end 

  get '/tweets/new' do 
    if !logged_in? 
      redirect '/login'
    end 
    erb :'tweets/new'
  end 

  post '/tweets' do 
    if params[:content].empty? 
      redirect '/tweets/new'
    end 
    user = current_user
    tweet = Tweet.new(content: params[:content])
    user.tweets << tweet 
    redirect '/tweets'
  end 

  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/user_tweets'
  end 
  
  get '/tweets/:id' do 
    if !logged_in?
      redirect '/login'
    end 
    @tweet = Tweet.find(params[:id])
    erb :'tweets/single'
  end 

  get '/tweets/:id/edit' do 
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect "/login"
    elsif @tweet.user_id != current_user.id 
      redirect "/tweets"
    end 

    erb :'tweets/edit'
  end 

  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id]) 
    if params[:content].empty? 
      redirect "/tweets/#{params[:id]}/edit"
    end 
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end 

end
