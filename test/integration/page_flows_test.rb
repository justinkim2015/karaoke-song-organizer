require "test_helper"

class PageFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:one)
    Rails.application.load_seed
  end

  test "Can see song#index" do
    get '/'
    assert_response :success
    assert_select "h1", "Songs:"
  end
end
