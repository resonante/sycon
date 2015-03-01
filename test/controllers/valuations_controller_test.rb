require 'test_helper'

class ValuationsControllerTest < ActionController::TestCase
  setup do
    @valuation = valuations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:valuations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create valuation" do
    assert_difference('Valuation.count') do
      post :create, valuation: {  }
    end

    assert_redirected_to valuation_path(assigns(:valuation))
  end

  test "should show valuation" do
    get :show, id: @valuation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @valuation
    assert_response :success
  end

  test "should update valuation" do
    patch :update, id: @valuation, valuation: {  }
    assert_redirected_to valuation_path(assigns(:valuation))
  end

  test "should destroy valuation" do
    assert_difference('Valuation.count', -1) do
      delete :destroy, id: @valuation
    end

    assert_redirected_to valuations_path
  end
end
