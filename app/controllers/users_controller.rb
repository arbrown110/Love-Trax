class UsersController < ApplicationController
    
    get '/register' do
      if signed_in?
        # redirect '/traxes/show'  **shows **
         redirect '/user/show'
     else
        erb :'/users/register'
     end
   end
    
  post '/register' do
    if params[:username] == "" || params[:password] == ""
      redirect '/register'
    else
      
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      #binding.pry **** not saving*****
      @user.save
      session[:user_id] = @user.id
      #binding.pry
      redirect '/traxes'
    end
  end
  
    get '/sign_in' do
      if signed_in?
        redirect '/traxes'
      else
        erb :'users/sign_in'
      end
    end
    
  post '/sign_in' do
    @user = User.find_by(:username => params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/traxes'
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