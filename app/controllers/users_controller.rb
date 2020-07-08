class UsersController < ApplicationController
    get '/users/sign_in' do
        erb :'/users/sign_in'
    end
end