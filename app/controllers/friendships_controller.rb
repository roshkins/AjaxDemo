class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:user_id])
    current_user.friends << @friend
    current_user.save!
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => @friend }
    end
  end

  def destroy
    Friendship.destroy_all(:friended_id => params[:user_id],
    :friender_id => current_user.id)
    redirect_to users_url
  end
end
