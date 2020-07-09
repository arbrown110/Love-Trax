require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'lovetrack'
  end

  get "/" do
    erb :welcome
  end

  helpers do 

    def current_user
      User.find_by(id: session[:user_id])
    end

    def signed_in?
      !!current_user
    end

    def authenticate
      redirect '/sign_in' if !logged_in?
    end

    def authorize_user(user)
      authenticate
      redirect '/users/show' if user != current_user
    end

    def authorize(trax)
      authenticate
      redirect '/trax' if trax.user != current_user
    end
  end  
end
