class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]


  def index
    @users = User.all
  end
  def show
    @user = current_user
  end

  def edit
  end

  def update
    Rails.logger.debug "User Params: #{user_params.inspect}"
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      Rails.logger.debug "Errors: #{@user.errors.full_messages}"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :location, :date_of_birth)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end

  def require_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
  
end
