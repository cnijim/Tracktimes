class VehiclesController < ApplicationController
  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = current_user.vehicles.create(vehicle_params)
    redirect_to root_path
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:year, :make, :model)
  end
end
