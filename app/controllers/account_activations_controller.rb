class AccountActivationsController < ApplicationController
  skip_before_action :authenticate_user?

  def edit
    user = User.find_by(email: params[:email])

    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login user
      flash[:success] = 'アカウントが有効化されました'
      redirect_to edit_user_url(user.name)
    else
      flash[:danger] = "無効なURLです"
      redirect_to root_url
    end
  end
end
