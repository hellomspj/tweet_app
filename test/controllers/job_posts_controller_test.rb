require "test_helper"

class JobPostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get interleaving" do
    get "/job_posts/interleaving", params: { user_id: 1, page: 1, per_page: 15 }
    assert_response :success

    json = JSON.parse(response.body)
    # デバッグ出力
    puts JSON.pretty_generate(json)


    assert_equal 15, json.size
    assert json.all? { |job| job["id"].is_a?(Integer) && ["new_algorithm", "old_algorithm"].include?(job["source"]) }
  end
end
