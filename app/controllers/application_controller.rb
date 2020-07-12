require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "lovetrax"
  end


  get '/' do 
    erb :welcome
  end

  #This is beautiful. SO I borrowed it from the Learn.co example.
  helpers do
    def redirect_if_not_signed_in
      if !signed_in?
        redirect "/Sign_in?error=You have to be signed in to do that"
      end
    end

    def signed_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end