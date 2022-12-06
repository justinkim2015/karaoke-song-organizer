class PlacesController < ApplicationController
  before_action :set_place, only: [:destroy, :edit, :update, :show]

  # def index
  #   @places = Place.all
  #   @place = Place.new
  #   zip_code = params[:zip]
  #   @location = current_user.location(request.ip)

  #   return if zip_code.nil?

  #   zip_info = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
  #   coordinates = JSON.parse zip_info, symbolize_names: true
  #   lat = coordinates[:results].first[:geometry][:location][:lat]
  #   long = coordinates[:results].first[:geometry][:location][:lng]

  #   response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat}%2C#{long}&radius=1000&keyword=karaoke&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
  #   @result = JSON.parse response, symbolize_names: true
  # end

  def index
    @places = Place.all
    @place = Place.new
    @location = current_user.location(request.ip)
    @lat = @location[:latitude]
    @long = @location[:longitude]

    # @lat = '35.683502'
    # @long = '139.657684'

    @nearby = @place.nearby(@lat, @long)

    @search_results = @place.search(params[:search])
  end

  def new
    @place = Place.new
  end

  def show
    @map_url = "https://www.google.com/maps/embed/v1/place?q=place_id:#{@place.place_id}&key=#{ENV["GOOGLE_MAPS_KEY"]}"

    store_info = @place.info

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
    if @place.update(place_params)
      redirect_back_or_to root_path
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
