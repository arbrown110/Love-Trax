class UsersController < ApplicationController
    
    get '/users/register' do
        if !signed_in?
          erb :'/users/register'
        else
          redirect to '/traxes' 
        end   
    end

    post '/users/register' do
        if params.values.any? {|value| value == ""}
            erb :'/users/register' 
        else
            @user = User.new( username: params[:username], email: params[:email],  password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/traxes/new'
        end    
            
    end
    
    get '/users/sign_in' do
        if !signed_in?
       # @user= User.find(session[:users_id])
        erb :'/users/sign_in'
        else
         redirect to '/traxes'     
        end
    end

    post '/users/sign_in' do
        @user = User.find_by(:username => parama[:username])
        if @user && @user= User.find_by(username params[:username])
            session[users_id] = @user.id
            redirect to '/traxes'
        else
            redirect "users/sign_in"   
        end      
    end 



    #get '/users/:id' do   #show page render data of one instance
        
    #    @user = User.find_by(params[:username])
    #     if @user == @user.id
    #     erb :'/users/show'
    #     else
    #        redirect '/users/sign_in'
    #    end
        
     
    #end
    
    get '/users/logout' do
        if session[:user_id] != nil
            session.destroy
            redirect '/'
        else 
            redirect to '/traxes/new'
        end
    end
end

