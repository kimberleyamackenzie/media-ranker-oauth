class SessionsController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      session[:user_id] = @user.id
        flash[:success] = "Welcome back #{@login_user.name}"
    else
      @user = User.new(uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['name'], username: @auth_hash['info']['nickname'], email: @auth_hash['info']['email'])
        if @user.save
          session[:user_id] = @user.id
          flash[:success] = "Welcome to MediaRanker, #{@login_user.name}"
        else
          flash[:error] = "Unable to save user!"
        end
    end
    redirect_to root_path
  end

  def index
    @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  end
end
