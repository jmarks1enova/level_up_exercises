require 'test_helper'

class EventAssetsControllerTest < ActionController::TestCase
  setup do
    @event_asset = event_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_asset" do
    assert_difference('EventAsset.count') do
      post :create, event_asset: { calendar_event_id: @event_asset.calendar_event_id, caption: @event_asset.caption, data: @event_asset.data, mime_type: @event_asset.mime_type }
    end

    assert_redirected_to event_asset_path(assigns(:event_asset))
  end

  test "should show event_asset" do
    get :show, id: @event_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_asset
    assert_response :success
  end

  test "should update event_asset" do
    patch :update, id: @event_asset, event_asset: { calendar_event_id: @event_asset.calendar_event_id, caption: @event_asset.caption, data: @event_asset.data, mime_type: @event_asset.mime_type }
    assert_redirected_to event_asset_path(assigns(:event_asset))
  end

  test "should destroy event_asset" do
    assert_difference('EventAsset.count', -1) do
      delete :destroy, id: @event_asset
    end

    assert_redirected_to event_assets_path
  end
end
