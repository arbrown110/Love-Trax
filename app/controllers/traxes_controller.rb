class TraxesController < ApplicationController

 # route to delete 
 delete '/traxes/:id' do
    gone = set_trax_entry
    if session[:user_id] != gone.user_id
    not_authorized_to_edit(@trax)
    else gone
      gone.destroy
      flash[:message] = "The entry is delete."
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
     if params[:name] !="" && params[:date] !="" && params[:score] !="" && params[:location] !="" && params[:number] !="" && params[:interest] !=""
     @trax.update(name: params[:name], date: params[:date], score: params[:score], location: params[:location], number: params[:number], interest: params[:interest]) 
     redirect "/traxes/#{@trax.id}"
     else
      flash[:error] = "Failed: #{@trax.errors.full_messages.to_sentence}"
      
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
    #
    if @trax.save
      
    flash[:message] = "You've created a new experience"
    redirect "/traxes/#{@trax.id}"
    else
      flash[:error] = "Failed: #{@trax.errors.full_messages.to_sentence}"
      redirect '/traxes/new'
    end  

  end

  get '/traxes/:id/edit' do
    #binding.pry
   @trax = Trax.find(params[:id])
   if authorize_to_edit?(@trax)
    erb :'/traxes/edit'
   else 
    flash[:error] = "Oh NO , You can't edit this!"
      redirect '/traxes'  
   end 
  end



  # show route for one trax experience
  get '/traxes/:id' do
    
    redirect_if_not_signed_in
    if !set_trax_entry
      redirect "/sign_in"   
    else
      erb :'/traxes/show'  #What does your dating life look if? coming from /TRAXES 
    end
  end


  #**In this order due to my program breaking if I place it in the proper order***



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

  # def authorized_to_edit?(trax)
  #   trax.user == current_user    
  # end  

  def not_authorized_to_edit(trax)
    if !authorize_to_edit?(trax)
     flash[:error] = "Oh NO , You can't edit this!"
     redirect '/'
    end
  end 
  
end