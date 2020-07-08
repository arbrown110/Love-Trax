class UsersController < ApplicationController
    
    
    
    
    get '/user/register' do
        erb :'/users/register'
    end

    post '/users/register' do
        @user = User.new( username: params[:username], email: params[:email],  password: params[:password])
        if @user.username == "" && @user.password == ""
            redirect "/users/register"
        else
            @user.save
            session[:user_id] = @user.id
            redirect "/user/#{@user.id}"
        end    

    end

    get '/users/sign_in' do
        erb :'/users/sign_in'
        redirect '/users/sign_in'
    end

    post '/users/sign_in' do

        @user = User.find_by(username: parama[:username])
        erb :'/users/sign_in'
        
        
    end 



    get '/user/:id' do   #show page render data of one instance
        
        @user = User.find_by(params[:username])
        erb :'/users/show'
        redirect '/'
    end    
end

