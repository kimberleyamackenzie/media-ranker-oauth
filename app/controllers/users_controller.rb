class UsersController < ApplicationController
  before_action :prevent_access

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  private
  def prevent_access
    if @login_user == nil
      flash[:result_text] = "Only logged in users can access that page."
      redirect_to root_path
    end
  end
end
