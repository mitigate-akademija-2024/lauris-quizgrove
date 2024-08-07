require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get questions_index_url
    assert_response :success
  end

  test "should get start" do
    get questions_start_url
    assert_response :success
  end

  test "should get test" do
    get questions_test_url
    assert_response :success
  end
end
