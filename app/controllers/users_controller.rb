class UsersController < ApplicationController

    get '/' do
        if logged_in?
            redirect '/tweets'
        else
            erb :index
        end
    end
    
    get '/signup' do
        # binding.pry
        if logged_in?
            # binding.pry
            redirect '/tweets'
        else 
            erb :'users/new'
        end
    end

    post '/signup' do 
        # binding.pry
        # @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        # if !params[:username]=="" && !params[:email].empty? && !params[:password].empty? 
        #     @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        # end 
       
        # binding.pry
        if params[:username]=="" || params[:email]=="" || params[:password]==""
            redirect '/signup'
        end
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        
        session[:user_id] = @user.id
        redirect "/tweets"
        # if @user.save
        #     session[:user_id] = @user.id
        #     # binding.pry
        #     redirect "/tweets"
        # else
        #     redirect '/signup'
        # end
    end

    get '/login' do
        
        if logged_in?
            redirect to "/tweets"
        else 
            erb :'/users/login'
        end
    end

    post '/login' do
        # binding.pry
        @user = User.find_by(username: params[:username])
        if @user != nil && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/tweets"
        end
        redirect to '/signup' if !logged_in? 
    end

    # get '/tweets' do
    #     erb :'users/tweets'
    # end

    # it "lets a user logout if they are already logged in and redirects to the login page" do

    # it 'redirects a user to the index page if the user tries to access /logout while not logged in' do

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            # erb :index
            redirect '/'
        end
    end

    # get "/users/#{user.slug}" do 
    #     "hellow"
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    # end

    


end