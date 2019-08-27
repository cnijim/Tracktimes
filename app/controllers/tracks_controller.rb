class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find_by_id([params[:id]])
  end

end
