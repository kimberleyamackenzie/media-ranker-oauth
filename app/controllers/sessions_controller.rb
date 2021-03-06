class SessionsController < ApplicationController

  def create
    @auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      session[:user_id] = @user.id
        flash[:result_text] = "Welcome back #{@user.name}"
    else
      @user = User.new(uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['name'], username: @auth_hash['info']['email'], email: @auth_hash['info']['email'])
        if @user.save
          session[:user_id] = @user.id
          flash[:result_text] = "Welcome to MediaRanker, #{@user.name}"
        else
          flash[:result_text] = "Unable to save user!"
        end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

  def index
    @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  end
end
