class SongsController < ApplicationController
  before_action :set_song, only: [:destroy, :edit, :update, :show]

  def index
    @songs = Song.all
    @song = current_user.songs.build

    search_term = params[:input]
    response = HTTParty.get("https://api.genius.com/search?q=#{search_term}&access_token=wnzQRHMIX9sj9vKrvXbFW-1ZMwr4SkENZ7VwUcmNOxpaJjnsdN9CiWurFJbkzBMs", format: :plain)
    @result = JSON.parse response, symbolize_names: true
  end

  def new
    @song = Song.new
  end

  def show
  end

  def create
    @song = current_user.songs.build(song_params)

    if @song.save
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

  private

  def song_params
    params.require(:song).permit(:artist, :title)
  end

  def set_song
    @song = Song.find(params[:id])
  end
end
