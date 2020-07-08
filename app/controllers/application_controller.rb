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
  get '/users/sing_in' do
    erb :'/users/sign_un'
  end
end
