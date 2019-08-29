class TracksController < ApplicationController
  before_action :authenticate_user!
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
      vehicleName = "#{vehicle.year} #{vehicle.make} #{vehicle.model}"
      puts "###############\n"
      puts vehicleName
      puts "###############\n"
      rowData[:vehicleName] = vehicleName
      rowData[:lapTime] = lap.lap_time
      rowData[:rank] = "TBD"
      rowData[:driver] = "TBD"
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
