class SecretsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Secret.all }
    end
  end

  def create
    @secret = Secret.new(params[:secret])
    @secret.author_id = current_user.id
    @secret.tag_ids = params[:tag_ids]
    @secret.save!

    respond_to do |format|
      format.html { redirect_to secrets_url }
      format.json { render :json => @secret }
    end
  end
end
