require "test_helper"

class SongTest < ActiveSupport::TestCase
  def setup
    @song = Song.first 
  end

  test 'Can see user' do
    assert @song.user
  end
end
