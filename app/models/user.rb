class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs
  has_many :places

  def location(ip)
    location = HTTParty.get("https://api.ip2location.com/v2/?key=#{ENV["IP_SEARCH_KEY"]}&ip=#{ip}&package=WS5&format=json&lang=en", format: :plain)
    JSON.parse location, symbolize_names: true
  end
end

lat = '35.683502'
long = '139.657684'

# "https://maps.googleapis.com/maps/api/directions/json?origin=#{lat},#{long}&destination=#{@place.place_id}&key=#{ENV["GOOGLE_MAPS_KEY"]}"
# "https://maps.googleapis.com/maps/api/directions/json?origin=35.683502,139.657684&destination=Montreal&key=AIzaSyBOCr9bjXnuMoxIQ4cIz5XWa5kOS-16izs"