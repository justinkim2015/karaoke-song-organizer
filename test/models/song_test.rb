require "test_helper"

class SongTest < ActiveSupport::TestCase
  def setup
    @song = Song.first 
  end

  test 'Can see user' do
    assert @song.user
  end

  test 'Can see artist' do
    assert @song.artist
  end
end
