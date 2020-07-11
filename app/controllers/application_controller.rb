require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    register Sinatra::Flash
  end

  get "/" do
    # change to a trax web page
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do

    def logged_in? # will return a boolean value
      !!current_user
    end

    def current_user #this will return a user based on the session id or nil
      @current_user ||= User.find_by(id: session[:user_id]) #used memoization to limit the number of database calls; if the value is stored in @current_user then we don't have to query the database to find the user.
    end

    def authorized_to_edit?(trax)
       trax.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view that page."
        redirect '/'
      end
    end

    def redirect_if_not_authorized_to_edit(trax)
       if !authorized_to_edit?(trax)
         flash[:errors] = "You must be the user to edit that experience."
         redirect '/'
      end
    end


  end

end
