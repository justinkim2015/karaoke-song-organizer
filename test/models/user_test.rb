require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.first 
  end

  test 'Can see songs' do
    assert @user.songs
  end
end
