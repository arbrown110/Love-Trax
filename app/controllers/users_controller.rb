class UsersController < ApplicationController
    
    get '/users/register' do
        erb :'/users/register'
    end

    post '/users/register' do
        @user = User.new( username: params[:username], email: params[:email],  password: params[:password])
        if @user.username == "" && @user.email == "" && @user.pasword == ""
            redirect "/users/register"
        else
            @user.save
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        end    

    end

    get '/users/sign_in' do
        erb :'/users/sign_in'
        
        redirect '/users/sign_in'
    end

    post '/users/sign_in' do

        @user = User.find_by(username: parama[:username])
        if @user && @user= User.find_by(username params[:username])
            session[user_id] = @user.id
            redirect "/users/#{@user.id}"

        else
            redirect "users/login"   
        end    
        
    end 



    get '/users/:id' do   #show page render data of one instance
        
        @user = User.find_by(params[:username])
        erb :'/user/show'
        redirect "/trax/#{@user.id}"
    end    
end

