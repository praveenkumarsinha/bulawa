require 'test_helper'

class TrackControllerTest < ActionDispatch::IntegrationTest
  test "should get entities" do
    get track_entities_url
    assert_response :success
  end

  test "should get events" do
    get track_events_url
    assert_response :success
  end

end
