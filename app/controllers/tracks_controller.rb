require 'net/http'
require 'json'

class TracksController < ApplicationController
  def index
    @tracksData = []
    @tracks = Track.all
    @tracks.each do |track|
      trackData = {}
      placeParam = "#{track.zip},#{track.country}"
      apiKey = "511ffbaf5f8b6c3e6a3c38975456fddd"
      resp = Net::HTTP.get('api.openweathermap.org',"/data/2.5/weather?APPID=#{apiKey}&zip=#{placeParam}")
      data = JSON.parse(resp)
      conditions = data['weather'][0]['main']
      tempK = data['main']['temp']
      tempF = convertKtoF(tempK)
      trackData[:name] = track.name
      trackData[:location] = "#{track.city}, #{track.state}"
      trackData[:weather] = "#{tempF}F, #{conditions}"
      trackData[:id] = track.id
      @tracksData << trackData
    end

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

  private

  def convertKtoF(temp)
    tempC = temp - 273.15
    tempF = (tempC * 9/5) + 32
    return tempF.round
  end

end
