class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])
    if @users.update(users_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @users = User.find_by(id: params[:id])
    @users.destroy
    redirect_to admin_users_path, notice: "User was successfully deleted."
  end

  private

  def set_user
    @users =User.find_id(id: params[:id])
  end
  def users_params
    params.require(:user).permit(:full_name, :email, :role, :location, :date_of_birth)
  end

  def authorize_admin
    redirect_to root_path, alert: "Access Denied" unless current_user.admin?
  end
end
