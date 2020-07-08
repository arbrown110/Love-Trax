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

  get '/users/register' do
    erb :'/users/register'
  end
  get '/users/sign_in' do
    erb :'/users/sign_in'
  end

  helpers do
    def logged_in?
      !!current_user
    end
    def current_user
      @current_user ||= User.find_by(:username => session[:username]) if session[:username]
  
    end
  end
end
