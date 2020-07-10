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
            redirect "/users/show"
        end    
            
    end
    
    get '/users/sign_in' do
        @user= User.find(session[:user_id])
     
        redirect "/users/#{@user.id}"
        
        #erb :'/users/sign_in'
        
    endshotgu

    post '/users/sign_in' do
        @user = User.find_by(username: parama[:username])
        if @user && @user= User.find_by(username params[:username])
            session[users_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect "users/sign_in"   
        end      
    end 



    get '/users/:id' do   #show page render data of one instance
        
        @user = User.find_by(params[:username])
         if @user == @user.id
         erb :'/users/show'
         else
            redirect '/users/sign_in'
         end
        end
     
    end
    
    get '/users/logout' do
        session.clear
        redirect '/'
    end


end