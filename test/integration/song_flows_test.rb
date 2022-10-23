require "test_helper"

class SongFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:one)
    Rails.application.load_seed

    @song = Song.first
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
      params: { song: {title: ""} }
    assert_response :unprocessable_entity
  end

  test "Can edit song" do
    get edit_song_path(@song.id)
    assert_response :success

    patch song_path(@song.id),
      params: { song: {title: "Chopped Suey", user_id: 1} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "li", "Chopped Suey"
  end

  test "can delete song" do
    get "/"
    assert_response :success

    delete song_path(@song.id)
    assert_response :redirect
  end
end
