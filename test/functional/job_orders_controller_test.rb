require 'test_helper'

class JobOrdersControllerTest < ActionController::TestCase
  setup do
    @job_order = job_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_order" do
    assert_difference('JobOrder.count') do
      post :create, :job_order => @job_order.attributes
    end

    assert_redirected_to job_order_path(assigns(:job_order))
  end

  test "should show job_order" do
    get :show, :id => @job_order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @job_order.to_param
    assert_response :success
  end

  test "should update job_order" do
    put :update, :id => @job_order.to_param, :job_order => @job_order.attributes
    assert_redirected_to job_order_path(assigns(:job_order))
  end

  test "should destroy job_order" do
    assert_difference('JobOrder.count', -1) do
      delete :destroy, :id => @job_order.to_param
    end

    assert_redirected_to job_orders_path
  end
end
