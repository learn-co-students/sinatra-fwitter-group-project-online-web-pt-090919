class TweetsController < ApplicationController
  
  before do
    require_login
  end

get '/tweets' do
  @tweets = Tweet.all
  erb :'tweets/index'
end

get '/tweets/new' do
  erb :'tweets/new'
end

post '/tweets' do
  @tweet = current_user.tweets.build(params[:content])
  if !params.empty?
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  else
    redirect "/tweets/new"
  end
end

get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  erb :'tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  erb :'tweets/edit'
end

patch '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  if !params[:content].empty?
    @tweet.update(params[:content])
    redirect "/tweets/#{@tweet.id}"
  else
    redirect "/tweet/#{@tweet.id}/edit"
  end 
end

delete "/tweet/:id" do
  @tweet = Tweet.find(params[:id])
  @tweet.destroy
  redirect "/tweets"
end



end
