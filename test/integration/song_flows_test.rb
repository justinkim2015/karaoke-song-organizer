require "test_helper"

class SongFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:one)
    Rails.application.load_seed
  end

  test "Can write new song" do
    get new_song_path
    assert_response :success
  end

  test "invalid input" do
  end

  test "Can edit song" do
  end
end
