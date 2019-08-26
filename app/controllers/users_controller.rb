class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @renderUserAdminButtons = true
    end
    @vehicle = Vehicle.where(["user_id = ?", params[:id]])
  end
end
