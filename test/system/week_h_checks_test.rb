require "application_system_test_case"

class WeekHChecksTest < ApplicationSystemTestCase
  setup do
    @week_h_check = week_h_checks(:one)
  end

  test "visiting the index" do
    visit week_h_checks_url
    assert_selector "h1", text: "Week H Checks"
  end

  test "creating a Week h check" do
    visit week_h_checks_url
    click_on "New Week H Check"

    click_on "Create Week h check"

    assert_text "Week h check was successfully created"
    click_on "Back"
  end

  test "updating a Week h check" do
    visit week_h_checks_url
    click_on "Edit", match: :first

    click_on "Update Week h check"

    assert_text "Week h check was successfully updated"
    click_on "Back"
  end

  test "destroying a Week h check" do
    visit week_h_checks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Week h check was successfully destroyed"
  end
end
