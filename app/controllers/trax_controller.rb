class TraxController < ApplicationController

    #create
    get '/trax/new' do
        erb :'/trax/new'
    end
    post '/trax' do
        @trax = Trax.create(
            name: params[:name], date: params[:date], 
            score: params[:score], location: params[:location], 
            number: params[:number], interest: params[:interest]
        )
        
        redirect "/trax/#{@trax.id}"
    end

    #review
    get '/trax/:id' do
      @trax = Trax.find(params[:users_id]) 
      erb :'/trax/show' 
    end

    post '/trax' do
        @trax = Trax.all #showing all of the experiences
        erb :'/trax/experience'
    end
    #edit
    get '/trax/:id/edit' do
        @trax = Trax.find(params[:id])
        erb :'/trax/edit'
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


