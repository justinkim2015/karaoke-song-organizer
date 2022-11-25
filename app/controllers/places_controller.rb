class PlacesController < ApplicationController
  def index
    @places = Place.all
    zip_info = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=168-0062&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
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
  end

  def create
    @song = current_user.songs.build(song_params)

    if @song.save
      @song.save_lyrics
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
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
    @song.destroy
    redirect_to root_path, status: :see_other
  end
end
