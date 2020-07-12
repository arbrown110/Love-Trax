class TraxesController < ApplicationController

  get '/traxes' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = @user.trax
    erb :'users/show'
  end

  

# Makes a new friend
  get '/traxes/new' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = Trax.all
    erb :'/traxes/new'
  end

  post '/traxes' do
    redirect_if_not_signed_in
    
    @trax=Trax.create(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest]
      
    )
    redirect "/traxes/#{@trax.id}"
    end

  # show route for one trax experience
  get '/traxes/:id' do
    redirect_if_not_signed_in
   # binding.pry
    if !set_trax_entry
      #flash[:errors] = "Please select a conference from the list on the conferences page."
      redirect "/sign_in" 
      #erb :'/traxes/experience'
    end
    #erb :'/traxes/experience' 
    redirect "/traxes/show"
  end

  get '/traxes/:id/edit' do
    @trax = Trax.find_by_id(params[:id])
    erb :'/traxes/edit'
  end

  post '/traxes/:id' do
    redirect_if_not_signed_in
    yo = current_user
    set_trax_entry
    @trax.update(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest]  
    ) 
    @trax.save
    redirect "/traxes/#{yo.id}"
    #redirect "/traxes/show"
  end


# route to delete 
  get '/traxes/:id/delete' do
    gone = set_trax_entry
    not_authorized_to_edit(@trax)
    yo = current_user
    if gone
      gone.destroy
      #flash[:message] = "The entry is delete."
      redirect "/traxes/#{yo.id}"
    end  
  end

  private

  def set_trax_entry
    @trax = Trax.find_by(id: params[:id])
  end

  def authorized_to_edit?(trax)
    trax.user == current_user    
  end  

  def not_authorized_to_edit(trax)
    if !authorized_to_edit?(trax)
      redirect '/'
    end
  end    
end