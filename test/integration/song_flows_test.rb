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

    post songs_path,
      params: { song: {title: "Chop Suey", user_id: 1} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Chop Suey"
  end

  test "invalid input" do
    get new_song_path
    assert_response :success

    post songs_path,
      params: { song: {title: "Chop Suey", user_id: 2} }
    assert_response :unprocessable_entity
  end

  test "Can edit song" do
  end
end
