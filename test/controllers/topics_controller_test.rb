require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      post :create, topic: { comments_num: @topic.comments_num, forum_id: @topic.forum_id, hits_num: @topic.hits_num, is_fixed: @topic.is_fixed, is_good: @topic.is_good, is_recommend: @topic.is_recommend, last_comment_time: @topic.last_comment_time, last_comment_user_id: @topic.last_comment_user_id, subject_id: @topic.subject_id, title: @topic.title, title_color: @topic.title_color, user_id: @topic.user_id }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    patch :update, id: @topic, topic: { comments_num: @topic.comments_num, forum_id: @topic.forum_id, hits_num: @topic.hits_num, is_fixed: @topic.is_fixed, is_good: @topic.is_good, is_recommend: @topic.is_recommend, last_comment_time: @topic.last_comment_time, last_comment_user_id: @topic.last_comment_user_id, subject_id: @topic.subject_id, title: @topic.title, title_color: @topic.title_color, user_id: @topic.user_id }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
  end
end
