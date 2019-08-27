class VehiclesController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = User.find(params[:user_id])
    if @user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
    @vehicle = Vehicle.new
  end

  def create
    @user = User.find(params[:user_id])
    if @user != current_user
      return render plain: 'Unauthorized', status: :unauthorized
    end
    @vehicle = current_user.vehicles.create(vehicle_params)
    redirect_to root_path
  end

  def show
    @vehicle = Vehicle.find_by_id([params[:id]])
    @vehicleOwnerId = @vehicle.user_id
    puts "show vehicle activated"
    puts @vehicleOwnerId
    @user = User.find_by_id(@vehicleOwnerId)
    # @vehicle = Vehicle.find(params[:vehicle_id])
    if @user == current_user
      @renderUserAdminButtons = true
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:year, :make, :model)
  end
end
