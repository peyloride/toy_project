require 'test_helper'

class LendsControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get lends_request_url
    assert_response :success
  end

  test "should get refuse" do
    get lends_refuse_url
    assert_response :success
  end

  test "should get accept" do
    get lends_accept_url
    assert_response :success
  end

  test "should get my_lends" do
    get lends_my_lends_url
    assert_response :success
  end

end
