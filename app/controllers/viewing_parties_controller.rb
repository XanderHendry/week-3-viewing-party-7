class ViewingPartiesController < ApplicationController 
  def new
    if current_user
      @user = User.find(params[:user_id])
      @movie = Movie.find(params[:movie_id])
    else
      flash[:error] = 'You must be logged in or registered to create a movie party'
      redirect_back(fallback_location: root_path)
    end
  end 
  
  def create 
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/users/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 
end 