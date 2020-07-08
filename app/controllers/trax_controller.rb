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
        erb :'/trax/experiences'
    end
    #edit

    #delete
end


