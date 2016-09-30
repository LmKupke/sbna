class UsersController < ApplicationController
  def show
    if params["id"] != current_user.id.to_s
      flash[:error] = "Sorry you do not have access to that profile!"
      redirect_to "root"
    end
    @user_info = current_user
  end
end
