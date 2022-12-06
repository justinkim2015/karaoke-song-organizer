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