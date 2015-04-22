require 'test_helper'

class ValuationItemsControllerTest < ActionController::TestCase
  setup do
    @valuation_item = valuation_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:valuation_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create valuation_item" do
    assert_difference('ValuationItem.count') do
      post :create, valuation_item: {  }
    end

    assert_redirected_to valuation_item_path(assigns(:valuation_item))
  end

  test "should show valuation_item" do
    get :show, id: @valuation_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @valuation_item
    assert_response :success
  end

  test "should update valuation_item" do
    patch :update, id: @valuation_item, valuation_item: {  }
    assert_redirected_to valuation_item_path(assigns(:valuation_item))
  end

  test "should destroy valuation_item" do
    assert_difference('ValuationItem.count', -1) do
      delete :destroy, id: @valuation_item
    end

    assert_redirected_to valuation_items_path
  end
end
