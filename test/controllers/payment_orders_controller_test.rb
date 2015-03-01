require 'test_helper'

class PaymentOrdersControllerTest < ActionController::TestCase
  setup do
    @payment_order = payment_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_order" do
    assert_difference('PaymentOrder.count') do
      post :create, payment_order: {  }
    end

    assert_redirected_to payment_order_path(assigns(:payment_order))
  end

  test "should show payment_order" do
    get :show, id: @payment_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_order
    assert_response :success
  end

  test "should update payment_order" do
    patch :update, id: @payment_order, payment_order: {  }
    assert_redirected_to payment_order_path(assigns(:payment_order))
  end

  test "should destroy payment_order" do
    assert_difference('PaymentOrder.count', -1) do
      delete :destroy, id: @payment_order
    end

    assert_redirected_to payment_orders_path
  end
end
