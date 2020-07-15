class TraxesController < ApplicationController

 # route to delete 
 delete '/traxes/:id' do
  binding.pry
  gone = set_trax_entry
  if session[:user_id] != gone.user_id
  not_authorized_to_edit(@trax)
  else gone
    gone.destroy
    #flash[:message] = "The entry is delete."
    redirect "/traxes/experience"
  end  
end
  

  get '/traxes' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = @user.traxes
    erb :'traxes/index'
  end



  patch '/traxes/:id' do
    redirect_if_not_signed_in
    
    yo = current_user
    set_trax_entry

    not_authorized_to_edit(@trax)
     if params[:name] !="" && params[:date] !="" && params[:score] !="" && params[:location] !="" && params[:number] !="" && params[:interest] 
     @trax.update(name: params[:name], date: params[:date], score: params[:score], location: params[:location], number: params[:number], interest: params[:interest]) 
      redirect "/traxes/#{@trax.id}"
     else
       redirect "/traxes/#{@trax.id}/edit"
     end 
  end
  

# Makes a new friend
  get '/traxes/new' do
    redirect_if_not_signed_in
    @user = current_user
    @trax = Trax.all
    
    erb :'/traxes/new'
  end

  
  post '/traxes/new' do
    redirect_if_not_signed_in
    @trax=Trax.create(name: params[:name], date: params[:date], 
      score: params[:score], location: params[:location], 
      number: params[:number], interest: params[:interest], 
      user_id: current_user.id
      
    )
    
    redirect "/traxes/#{@trax.id}"
  end

  get '/traxes/:id/edit' do
    redirect_if_not_signed_in
    set_trax_entry
    erb :'/traxes/edit'
  end



  # show route for one trax experience
  get '/traxes/:id' do
    redirect_if_not_signed_in
   
     if !set_trax_entry
       #flash[:errors] = "Please select a conference from the list on the conferences page."
       redirect "/sign_in"   
     end
      erb :'/traxes/show'  #What does your dating life look if? coming from /TRAXES 
    end
  end

  # get '/traxes/:id/edit' do
  #   redirect_if_not_signed_in
  #   binding.pry
  #   set_trax_entry
  #   erb :'/traxes/edit'
  # end

  # patch '/traxes/:id' do
  #   redirect_if_not_signed_in
  #    binding.pry
  #   yo = current_user
  #   set_trax_entry

  #   not_authorized_to_edit(trax)
  #    if params[:name] !="" && params[:date] !="" && params[:score] !="" && params[:location] !="" && params[:number] !="" && params[:interest] 
  #    @trax.update(name: params[:name], date: params[:date], score: params[:score], location: params[:location], number: params[:number], interest: params[:interest]) 
  #     # redirect "/traxes/#{yo.id}"
  #     redirect "/traxes/#{@trax.id}"
  #    else
  #      redirect "/traxes/#{@trax.id}/edit"
  #    end
  #     # redirect "/traxes/#{@trax.id}/show"
   
  # end


# route to delete 
  # delete '/traxes/:id' do
  #   binding.pry
  #   gone = set_trax_entry
  #   if session[:user_id] != gone.user_id
  #   not_authorized_to_edit(@trax)
  #   else gone
  #     gone.destroy
  #     #flash[:message] = "The entry is delete."
  #     redirect "/traxes/experience"
  #   end  
  # end

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