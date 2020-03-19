require 'test_helper'

class Admin::SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_subjects_index_url
    assert_response :success
  end

end
