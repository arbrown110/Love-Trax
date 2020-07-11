class TraxesController < ApplicationController

     # index route for all conferences
  get '/traxes' do
    redirect_if_not_logged_in
    @traxes = Trax.all
    erb :'/traxes/index'
  end

  # get traxes/new to render a form to create a new experience
  get '/traxes/new' do
    redirect_if_not_logged_in
    erb :'/traxes/new'
  end

  # post traxes to create a new 
  post '/traxes' do
    # raise params.inspect
    # create the entry if a user is logged in
    redirect_if_not_logged_in
    # save the entry if it has fields completed
    if params[:name] != "" && params[:date] != ""  && params[:score] != "" && params[:location] != "" && params[:number] != "" && params[:interest] 
      flash[:message] = "You have successfully created a new Experience."
      @trax = Trax.create(name: params[:name], date: params[:date] , score: params[:score], location: params[:location], number: params[:number], interest: params[:interest], user_id: current_user.id) # @trax = current_user.traxes.build(params[:trax])
      redirect "/traxes/#{@trax.id}"
    else
      flash[:errors] = "Please complete all fields."
      redirect "traxes/new"
    end

  end

  # show route for one trax experience
  get '/traxes/:id' do
    redirect_if_not_logged_in
    if !set_conference_entry
      flash[:errors] = "Please select a conference from the list on the conferences page."
      redirect "/traxes"
    end
    erb :'/traxes/show'
  end

  # route to edit 
  get '/traxes/:id/edit' do
    set_trax_entry
    redirect_if_not_logged_in
    redirect_if_not_authorized_to_edit(@trax)
    erb :'/traxes/edit'
    # if authorized_to_edit?(@trax)
    #   erb :'/traxes/edit'
    # else
    #   redirect "users/#{current_user.id}"
    # end
  end

  # this route updates the trax
  patch '/traxes/:id' do
    # find the trax experience
    set_trax_entry
    # modify the trax
    # binding.pry
    redirect_if_not_logged_in
    redirect_if_not_authorized_to_edit(@trax)
      if params[:name] != "" && params[:location] != "" && params[:category] != "" && params[:date] != ""
        @trax.update(name: params[:name], location: params[:location], category: params[:category], date: params[:date])
        redirect "/traxes/#{@trax.id}"
      else
        redirect "/traxes/#{@trax.id}/edit"
      end
  end


# route to delete a conference
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