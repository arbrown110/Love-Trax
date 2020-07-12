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
    erb :'/trax/new'
  end

  post '/trax' do
    redirect_if_not_signed_in
    @trax=Trax.create(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest],
      user_id:  params[:interest]
    )
    redirect '/trax/show'
    end

  # show route for one trax experience
  get '/trax/:id' do
    redirect_if_not_signed_in
    if !set_trax_entry
      #flash[:errors] = "Please select a conference from the list on the conferences page."
      redirect "/trax/show"
    end
    erb :'/trax/experience'
  end

  get '/trax/:id/edit' do
    @trax = Trax.find_by_id(params[:id])
    erb :'/trax/edit'
  end

  patch '/trax/:id' do
    @trax = Task.find_by_id(params[:id])
    @trax.name = params[:name]
    @trax.save
    redirect '/trax'
  end


# route to delete 
  delete '/trax/:id' do
    set_trax_entry
    redirect_if_not_authorized_to_edit(@trax)
      @trax.destroy
      flash[:message] = "The entry is delete."
      redirect "/trax"
  end

  private

  def set_trax_entry
    @trax = Trax.find_by(id: params[:id])
  end

end