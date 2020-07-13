class TraxesController < ApplicationController

  get '/traxes' do
    redirect_if_not_signed_in
    #binding.pry
    @user = current_user
    #binding.pry
    @trax = @user.traxes
    #erb :'users/show'
    #erb :'/traxes/show' #shows empty experience
    erb :'traxes/experience'
  end

  

# Makes a new friend
  get '/traxes/new' do
    redirect_if_not_signed_in
    #binding.pry
    @user = current_user
    @trax = Trax.all
    #erb :'/traxes/show'  *** gives me all of the experience info not just the recent**
    erb :'/traxes/new'
  end

  post '/traxes/new' do
    redirect_if_not_signed_in
    #binding.pry
    @trax=Trax.create(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest], 
      user_id: current_user.id
      
    )
    
    redirect "/traxes/#{@trax.id}"
  end

  # show route for one trax experience
  get '/traxes/:id' do
    redirect_if_not_signed_in
   
     if !set_trax_entry
       #flash[:errors] = "Please select a conference from the list on the conferences page."
       redirect "/sign_in" 
       #erb :'/traxes/experience'
     end
      erb :'/traxes/experience'  #What does your dating life look if? coming from /TRAXES
      #redirect "/traxes/show"
    end
  end

  get '/traxes/:id/edit' do
    redirect_if_not_signed_in
    binding.pry
    set_trax_entry
    erb :'/traxes/edit'
  end

  patch '/traxes/:id' do
    redirect_if_not_signed_in
    binding.pry
    yo = current_user
    set_trax_entry

   # not_authorized_to_edit(trax)
    #  if params[:name] !="" && params[:date] !="" && params[:score] !="" && params[:location] !="" && params[:number] !="" && params[:interest] 
    #    @trax.update(name: params[:name], date: params[:date], score: params[:score], location: params[:location], number: params[:number], interest: params[:interest]) 
    #    redirect "/traxes/#{yo.id}"
    #  else
    #    redirect "/traxes/#{@trax.id}/edit"
    #  end
      #redirect "/traxes/show" 
  end


# route to delete 
  get '/traxes/:id/delete' do
    gone = set_trax_entry
    binding.pry
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