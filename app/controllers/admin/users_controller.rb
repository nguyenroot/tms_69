class Admin::UsersController < ApplicationController
  before_action :verify_admin
  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.users.update.update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.admin.users.flash.success.delete_user"
    else
      flash[:danger] = t "controllers.admin.users.flash.fail.delete_user"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :chatwork_id, :password, :password_confirmation
  end

end
