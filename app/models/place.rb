class Place < ApplicationRecord
  belongs_to :user
  # geocoded_by :place_id

  def info
    url = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&fields=current_opening_hours&key=#{ENV["GOOGLE_MAPS_KEY"]}",  format: :plain)
    JSON.parse url, symbolize_names: true
  end

  def open?(info)
    if info[:result][:current_opening_hours][:open_now] == true
      'OPEN'
    else
      'CLOSED'
    end
  end

  def hours(info)
    info[:result][:current_opening_hours][:weekday_text]
  end

  def distance_to(lat, long, place)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{lat},#{long}&destination=place_id:#{place}&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
    info = JSON.parse response, symbolize_names: true
    info[:routes][0][:legs][0][:distance][:text]
  end

  def nearby(lat, long)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat}%2C#{long}&radius=1000&keyword=karaoke&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
    JSON.parse response, symbolize_names: true
  end

  def search(query)
    search = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{query}&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)

    coordinates = JSON.parse search, symbolize_names: true
    
    return if coordinates[:results].first.nil?

    lat = coordinates[:results].first[:geometry][:location][:lat]
    long = coordinates[:results].first[:geometry][:location][:lng]

    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat}%2C#{long}&radius=1000&keyword=karaoke&key=#{ENV["GOOGLE_MAPS_KEY"]}", format: :plain)
    JSON.parse response, symbolize_names: true
  end
end
