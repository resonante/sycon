require 'test_helper'

class PurchaseOrderItemsControllerTest < ActionController::TestCase
  setup do
    @purchase_order_item = purchase_order_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_order_item" do
    assert_difference('PurchaseOrderItem.count') do
      post :create, purchase_order_item: {  }
    end

    assert_redirected_to purchase_order_item_path(assigns(:purchase_order_item))
  end

  test "should show purchase_order_item" do
    get :show, id: @purchase_order_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_order_item
    assert_response :success
  end

  test "should update purchase_order_item" do
    patch :update, id: @purchase_order_item, purchase_order_item: {  }
    assert_redirected_to purchase_order_item_path(assigns(:purchase_order_item))
  end

  test "should destroy purchase_order_item" do
    assert_difference('PurchaseOrderItem.count', -1) do
      delete :destroy, id: @purchase_order_item
    end

    assert_redirected_to purchase_order_items_path
  end
end
