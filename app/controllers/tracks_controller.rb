class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @tableData = []
    @track = Track.find_by_id([params[:id]])
    @laps = Lap.where(["track_id = ?", @track.id])
    @laps.each do |lap|
      rowData = {}
      vehicle = Vehicle.find(lap.vehicle_id)
      user = User.find(vehicle.user_id)
      vehicleName = "#{vehicle.year} #{vehicle.make} #{vehicle.model}"
      lapTime = "#{lap.lap_time_minutes}:#{lap.lap_time_seconds.to_s.rjust(2, "0")}.#{lap.lap_time_hundreds.to_s.rjust(2, "0")}"
      puts "###############\n"
      puts vehicleName
      puts "###############\n"
      rowData[:vehicleName] = vehicleName
      rowData[:lapTime] = lapTime
      rowData[:rank] = "TBD"
      rowData[:driver] = user.driver_name
      rowData[:userId] = vehicle.user_id
      rowData[:vehicleId] = lap.vehicle_id
      @tableData << rowData
    end
  end

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

end
