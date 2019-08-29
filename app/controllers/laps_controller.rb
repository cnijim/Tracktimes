class LapsController < ApplicationController
  def new
    @lap = Lap.new
    @tracks = Track.all
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    puts "vehicle found:"
    puts @vehicle
    @lap = @vehicle.laps.create(lap_params)
    redirect_to root_path
  end

  private

  def lap_params
    params.require(:lap).permit(:lap_time, :track_id, :date)
  end
end
