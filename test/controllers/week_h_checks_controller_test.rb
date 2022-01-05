require 'test_helper'

class WeekHChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @week_h_check = week_h_checks(:one)
  end

  test "should get index" do
    get week_h_checks_url
    assert_response :success
  end

  test "should get new" do
    get new_week_h_check_url
    assert_response :success
  end

  test "should create week_h_check" do
    assert_difference('WeekHCheck.count') do
      post week_h_checks_url, params: { week_h_check: {  } }
    end

    assert_redirected_to week_h_check_url(WeekHCheck.last)
  end

  test "should show week_h_check" do
    get week_h_check_url(@week_h_check)
    assert_response :success
  end

  test "should get edit" do
    get edit_week_h_check_url(@week_h_check)
    assert_response :success
  end

  test "should update week_h_check" do
    patch week_h_check_url(@week_h_check), params: { week_h_check: {  } }
    assert_redirected_to week_h_check_url(@week_h_check)
  end

  test "should destroy week_h_check" do
    assert_difference('WeekHCheck.count', -1) do
      delete week_h_check_url(@week_h_check)
    end

    assert_redirected_to week_h_checks_url
  end
end
