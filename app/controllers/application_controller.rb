require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "lovetrax"
  end


  get '/' do 
    erb :'users/sign_in'
  end

  
  helpers do
    def redirect_if_not_signed_in
      if !signed_in?
        redirect "/sign_in"
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