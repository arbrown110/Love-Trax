class UsersController < ApplicationController
    
    # Route for logging in
  get '/sign_in' do
    erb :'users/sign_in'

  end

  # receive the login the sign in  form, find the user and log the user in (create a session)
  post '/sign_in' do
    # find the user
    @user = User.find_by(username: params[:username])
    # authenticate the user - verify the user by userame & password
    if @user && @user.authenticate(params[:password])
    # log the user in - create the session
    # redirect to the user's landing page (show? index?  dashboard?)
      flash[:message] = "Welcome, #{@user.name}!"
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
    # tell the user they entered invalid credentials - add flash message
    flash[:errors] = "Your credentials were invalid. Please register or try again."
    # redirect to the login page
    redirect "/sign_in"

    end
  end

  # Route for  register
  # Render the register form
  get '/register' do
    erb :'/users/register'

  end
  post '/users/register' do
    if params.values.any? {|value| value == ""}
    redirect to '/register' 
    else
      @user = User.new( username: params[:username], email: params[:email],  password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/traxes/index'
    end    
 #   "hello world"
  end

  post '/users' do
    # params will be {"name"=>"user", "email"=>"user@email.com", "password"=>"password"}
    # only persist new user with name, email and password
    @user = User.new(params)
    if @user.save # persist the user to the database
      session[:user_id] = @user.id # login the user
      flash[:message] = "You have successfully created an account #{@user.name}! Welcome!"
      redirect "/users/#{@user.id}"
    else
      # not valid input
      # tell the user they entered invalid credentials - add flash message
      # redirect to the login page
      flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}."
      redirect "/register"
    end

  end

  get '/users/:id' do
    # raise params.inspect
    @user = User.find_by(id: params[:id])
    redirect_if_not_logged_in
    # binding.pry
    erb :'/users/show'
  end

  get '/sign_out' do
    session.clear
    redirect '/'
  end

end