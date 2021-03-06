require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:product_one)
    @update = {
      :title       => 'Lorem Ipsum',
      :description => 'Wibbles are fun!',
      :image_url   => 'lorem.jpg',
      :price       => 19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_select '#columns #side a', :text => 'Home'
    assert_select '#columns #side a', :text => 'Questions'
    assert_select '#columns #side a', :text => 'News'
    assert_select '#columns #side a', :text => 'Contact'
    assert_select 'div#time'
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should not destroy product" do
    #Product should not be destoryed as it is referenced by a line item
    assert_difference('Product.count', 0) do
      delete :destroy, :id => products(:product_one)
    end

    assert_redirected_to products_path
  end

  test "shoulddestroy product" do
    #Product should be destoryed as it is not referenced by any line item
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:product_ruby)
    end

    assert_redirected_to products_path
  end

end
