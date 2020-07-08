class UsersController < ApplicationController
    
    
    
    
    get '/user/sign_in' do
        erb :'/users/sign_in'
    end

    post '/users/sign_in' do
        @user = User.create(username: params[:username], password: params[:password])
        redirect "/user/#{@user.id}"
    end

    get '/user/:id' do   #show page render data of one instance
        erb :'/users/show'
        @user = User.find(params[:id])
    end    
end