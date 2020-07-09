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
        if signed_in?
            @user= User.find(sesion[:id])    
            redirect "/users/#{@user.id}"
        else
            erb :'/users/sign_in'
        end    
    end

    post '/users/sign_in' do

        @user = User.find_by(username: parama[:username])
        if @user && @user= User.find_by(username params[:username])
            session[users_id] = @user.id
            redirect "/users/#{@user.id}"

        else
            redirect "users/login"   
        end    
        
    end 



    get '/users/:id' do   #show page render data of one instance
        
        @user = User.find_by(params[:username])
        erb :'/user/show'
        
    end
    
    get '/users/logout' do
        session.clear
        redirect '/'
    end
end

