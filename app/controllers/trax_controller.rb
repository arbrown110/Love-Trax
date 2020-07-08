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
      @trax = Trax.find(params[:id]) 
      erb :'/trax/show' 
    end

    post '/trax' do
        @trax = Trax.all #showing all of the experiences
        erb :'/trax/experience'
    end
    #edit
    get '/trax/:id/edit' do
        @trax = Trax.fin(params[:id])
        erb :'/trax/edit'
    end

    patch '/trax/:id' do
        @trax = Trax.find(params[:id])
        @trax = Trax.update(
            name: params[:name], date: params[:date], 
            score: params[:score], location: params[:location], 
            number: params[:number], interest: params[:interest]
        )
        redirect "/trax/#{@trax.name}"
    end
    #delete
    delete '/trax/:id' do
     @trax = Trax.find(params [:id])   
     @trax.destroy
     redirect '/trax'
    end

end


