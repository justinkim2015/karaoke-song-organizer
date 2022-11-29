class PlacesController < ApplicationController
  before_action :set_place, only: [:destroy, :edit, :update, :show]

  def index
    @places = Place.all
    @place = Place.new
    zip_code = params[:zip]
    @ip = request.ip

    return if zip_code.nil?

    # https://api.ip2location.com/v2/?key=N8118CAWI4&ip=8.8.8.8&package=WS5&format=json&lang=en

    zip_info = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
    coordinates = JSON.parse zip_info, symbolize_names: true
    lat = coordinates[:results].first[:geometry][:location][:lat]
    long = coordinates[:results].first[:geometry][:location][:lng]

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat}%2C#{long}&radius=1000&keyword=karaoke&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
    @result = JSON.parse response, symbolize_names: true
  end

  def new
    @place = Place.new
  end

  def show
    @map_url = "https://www.google.com/maps/embed/v1/place?q=place_id:#{@place.place_id}&key=#{ENV["GOOGLE_MAPS_KEY"]}"

    url = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{@place.place_id}&fields=current_opening_hours&key=#{ENV["GOOGLE_MAPS_KEY"]}",  format: :plain)
    store_info = JSON.parse url, symbolize_names: true

    @status = @place.open?(store_info)
    @hours = @place.hours(store_info)
  end

  def create
    @place = current_user.places.build(place_params)

    redirect_to @place if @place.save
  end

  def edit
  end

  def update
    if @song.update(song_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place.destroy
    redirect_back_or_to root_path, status: :see_other
  end

  private

  def place_params
    params.require(:place).permit(:name, :user_id, :place_id, :lat, :lng)
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
