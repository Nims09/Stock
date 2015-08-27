require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post :create, tag: { name: @tag.name, sentiment: @tag.sentiment }
    end

    assert_response 201
  end

  test "should show tag" do
    get :show, id: @tag
    assert_response :success
  end

  test "should update tag" do
    put :update, id: @tag, tag: { name: @tag.name, sentiment: @tag.sentiment }
    assert_response 204
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete :destroy, id: @tag
    end

    assert_response 204
  end
end
