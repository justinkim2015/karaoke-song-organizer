class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :title)
  end
end
