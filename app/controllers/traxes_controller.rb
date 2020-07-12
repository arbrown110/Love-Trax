class TraxesController < ApplicationController

  get '/trax' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = @user.trax
    erb :'users/show'
  end

  

# Makes a new friend
  get '/trax/new' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = Trax.all
    erb :'/traxes/new'
  end

  post '/trax' do
    redirect_if_not_signed_in
    @trax=Trax.create(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest],
      user_id:  params[:interest]
    )
    redirect "/traxes/#{@trax.id}"
    end

  # show route for one trax experience
  get '/traxes/:id' do
    redirect_if_not_signed_in
    if !set_trax_entry
      #flash[:errors] = "Please select a conference from the list on the conferences page."
      redirect "/traxes/show"
    end
    erb :'/traxes/experience'
  end

  get '/traxes/:id/edit' do
    @trax = Trax.find_by_id(params[:id])
    erb :'/trax/edit'
  end

  patch '/traxes/:id' do
    @trax = Task.find_by_id(params[:id])
    @trax.name = params[:name]
    @trax.save
    redirect '/traxes'
  end


# route to delete 
  delete '/traxes/:id' do
    set_trax_entry
    redirect_if_not_authorized_to_edit(@trax)
      @trax.destroy
      flash[:message] = "The entry is delete."
      redirect "/traxes"
  end

  private

  def set_trax_entry
    @trax = Trax.find_by(id: params[:id])
  end

end