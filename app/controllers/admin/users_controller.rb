class Admin::UsersController < Admin::ApplicationController
  before_action :superadmin_user?, except: [:index]
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def edit
  end

  def update
    params[:user][:role_level] = params[:user][:role_level].to_i
    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to admin_users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_level)
    end

    def superadmin_user?
      if !superadmin?
        raise ActionController::RoutingError.new(params[:path])
      end
    end
end
