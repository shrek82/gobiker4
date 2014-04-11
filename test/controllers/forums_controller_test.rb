require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  setup do
    @forum = forums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forum" do
    assert_difference('Forum.count') do
      post :create, forum: { category_id: @forum.category_id, city_id: @forum.city_id, club_id: @forum.club_id, icon_path: @forum.icon_path, intro: @forum.intro, is_systemic: @forum.is_systemic, name: @forum.name, order_num: @forum.order_num, province_id: @forum.province_id, topics_num: @forum.topics_num }
    end

    assert_redirected_to forum_path(assigns(:forum))
  end

  test "should show forum" do
    get :show, id: @forum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forum
    assert_response :success
  end

  test "should update forum" do
    patch :update, id: @forum, forum: { category_id: @forum.category_id, city_id: @forum.city_id, club_id: @forum.club_id, icon_path: @forum.icon_path, intro: @forum.intro, is_systemic: @forum.is_systemic, name: @forum.name, order_num: @forum.order_num, province_id: @forum.province_id, topics_num: @forum.topics_num }
    assert_redirected_to forum_path(assigns(:forum))
  end

  test "should destroy forum" do
    assert_difference('Forum.count', -1) do
      delete :destroy, id: @forum
    end

    assert_redirected_to forums_path
  end
end
