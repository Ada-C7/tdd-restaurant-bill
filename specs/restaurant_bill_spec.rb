require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'

describe "Testing RestaurantBill Class" do
  describe "Create new instance of RestaurantBill Class" do
    it "New instance of RestaurantBill is created" do
      bill = RestaurantBill.new
      bill.class.must_equal RestaurantBill
    end

    it "RestaurantBill initializes no ordered items" do
      bill = RestaurantBill.new
      bill.ordered_items.must_be_empty
    end

    it "RestaurantBill stores orded items in an array" do
      bill = RestaurantBill.new
      bill.ordered_items.class.must_equal Array
    end
  end

  describe "Order Item Method" do

    it "Order item adds item to ordered items list" do
      bill = RestaurantBill.new
      bill.order_item("Pancakes", 7)

      bill.ordered_items.wont_be_empty
    end

    it "Order item adds one element to ordered items list" do
      bill = RestaurantBill.new
      bill.order_item("Pancakes", 7)

      bill.ordered_items.length.must_equal 1
    end

    it "When order items is called 3 times, ordered items has 3 elements" do
      bill = RestaurantBill.new
      bill.order_item("Pancakes", 7)
      bill.order_item("Coffee", 3)
      bill.order_item("Bacon", 3)

      bill.ordered_items.length.must_equal 3
    end
  end

  it "See total cost of all items with tax" do
    bill = RestaurantBill.new
    bill.order_item("Pancakes", 7)
    bill.order_item("Coffee", 3)
    bill.order_item("Bacon", 3)

    item_total = 7 + 3 + 3
    tax = item_total * 0.057
    final_total = (item_total + tax).round(2)

    bill.item_total.must_equal final_total
  end


  it "Tipping is added to total cost" do
    bill = RestaurantBill.new
    bill.order_item("Pancakes", 7)
    bill.order_item("Coffee", 3)
    bill.order_item("Bacon", 3)

    bill.item_total
    tip = 2
    bill.add_tip(tip)

    item_total = 7 + 3 + 3
    tax = item_total * 0.057
    final_total = (item_total + tax).round(2)
    final_total_with_tip = final_total + tip


    bill.total.must_equal final_total_with_tip
  end

  it "RestaurantBill has tip, total and ordered_items attributes" do
    bill = RestaurantBill.new

    proc {
      bill.total
      bill.tip
      bill.ordered_items
    }.must_be_silent

  end


end
