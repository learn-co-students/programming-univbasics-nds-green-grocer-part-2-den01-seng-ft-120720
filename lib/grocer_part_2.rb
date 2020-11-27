require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon_item|
    item4markdown = find_item_by_name_in_collection(coupon_item[:item], cart)
    if item4markdown[:count] >= coupon_item[:num]
      item4markdown[:count] = item4markdown[:count] - coupon_item[:num]
      cart << {
        :item => "#{item4markdown[:item]} W/COUPON",
        :price => (coupon_item[:cost] / coupon_item[:num]).round(2),
        :clearance => item4markdown[:clearance],
        :count => coupon_item[:num]
      }
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance]
      item[:price] = (0.8 * item[:price]).round(2)
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  customer_total = 0.00
  cart_consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(cart_consolidated, coupons)
  clearances_applied = apply_clearance(coupons_applied)

  clearances_applied.each do |item|
    customer_total += (item[:price] * item[:count]).round(2)
  end

  if customer_total > 100.00
    customer_total = (0.9 * customer_total).round(2)
  else
    customer_total
  end

end
