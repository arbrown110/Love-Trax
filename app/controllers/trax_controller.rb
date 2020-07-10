class TraxController < ApplicationController

    #create
    get '/trax/new' do
        if logged_in?
            @trax = Trax.all
            erb :'trax/index'
        else
            erb :'users/sing_in'
        end
    end
    
    post '/trax' do
        if params.values.any? {|value| value == ""}
            erb :'trax/new'
        else
            user = User.find(session[:user_id])
            @trax = Trax.create(
                name: params[:name], date: params[:date], 
                score: params[:score], location: params[:location], 
                number: params[:number], interest: params[:interest]
            )
            redirect to "/trax/#{@trax.id}"
        end
    end

    #review
    get '/trax/:id' do
      if signed_in?
        @trax = Trax.find(params[:users_id]) 
        erb :'/trax/show'
      else
         erb :'users/sign_in' 
      end

    end

    
    #edit
    get '/trax/:id/edit' do
        if logged_in?
            @trax = Trax.find(params[:id])
            if @project.user_id == session[:user_id]
             erb :'/trax/edit'
            else
            erb :'trax'
            end
          else
            erb :'users/sign_in'
          end
        end
        
    end

    patch '/trax/:id' do
        if params.value.any? {|value|value == ""}
            redirect to "/trax/#{@trax.id}/edit" 
        else   
        @trax = Trax.find(params[:id])
        @trax = Trax.update(
            name: params[:name], date: params[:date], 
            score: params[:score], location: params[:location], 
            number: params[:number], interest: params[:interest]
        )
        @trax.save
        redirect to "/trax/#{@trax.id}"
    end
    #delete
    delete '/trax/:id/delete' do
     @trax = Trax.find(params [:id])  
     if session[:user_id]
        @trax = Trax.find(params[:id])
        if @trax.user_id == session[:user_id]
          @trax.delete
          redirect to '/trax'
        else
          redirect to '/trax'
        end
      else
        redirect to '/sign_in'
      end
    end

end


