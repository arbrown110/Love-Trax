class UsersController < ApplicationController
    
    get '/register' do
      if signed_in?
         redirect '/tasks'
     else
        erb :'users/register'
     end
   end
    
  post '/register' do
    if params[:username] == "" || params[:password] == ""
      redirect '/register'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/trax'
    end
  end
  
    get '/sign_in' do
      if signed_in?
        redirect '/trax'
      else
        erb :'users/sign_in'
      end
    end
    
  post '/sign_in' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/trax'
    else
      redirect '/sign_in'
    end
  end
    
  get '/sign_out' do
    if session[:user_id] != nil
      session.clear
      redirect to '/sign_in'
    else
      redirect to '/'
    end
  end
    
end