class UsersController < ApplicationController
    
    get '/register' do
      if signed_in?
         redirect '/user/show'
     else
        erb :'/users/register'
     end
   end
    
  post '/register' do
    if params[:username] == "" || params[:password] == ""
      flash[:error] = "You missed a spot!!"
      redirect '/register'
    else 
      
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save

      if  !@user.save  
        flash[:error] = "This already exist!"
         redirect '/register'
      else
        session[:user_id] = @user.id
      redirect '/traxes'
      end
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
      flash[:message] = "SUCCESS!!"
      redirect '/traxes'
    else
      flash[:error] = "Sorry, try again my friend."

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