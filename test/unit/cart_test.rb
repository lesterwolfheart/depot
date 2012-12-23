require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "add unique products" do
    @cart = Cart.create
    @book_one = products(:product_one)
    @book_two = products(:product_two)
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_two.id).save!
    assert_equal 2, @cart.line_items.size
    assert_equal @book_one.price + @book_two.price, @cart.total_price
  end

  test "add duplicate product" do
    @cart = Cart.create
    @ruby_book = products(:product_ruby)
    @cart.add_product(@ruby_book.id).save!
    @cart.add_product(@ruby_book.id).save!
    assert_equal 2*@ruby_book.price, @cart.total_price
    assert_equal 1, @cart.line_items.size
    assert_equal 2, @cart.line_items[0].quantity
  end
end
