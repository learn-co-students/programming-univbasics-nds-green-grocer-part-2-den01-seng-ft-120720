require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart

  cart.each do |cart_item|
    active_coupon = find_item_by_name_in_collection(cart_item[:item], coupons)
    if active_coupon != nil
      if cart_item[:count] >= active_coupon[:num]
        num_items = active_coupon[:num]
        
        # Create discount_item
        discount_item = {
          :item => cart_item[:item] + " W/COUPON",
          :price => active_coupon[:cost] / num_items,
          :clearance => cart_item[:clearance],
          :count => active_coupon[:num]
        }
        
        # Add item with discount to updated cart
        cart << discount_item
        
        # Update number of cart item after applying coupon
        cart_item[:count] = cart_item[:count] - num_items

      end
    end
  end
  
  cart
end

# def apply_coupons(cart, coupons)
#   # REMEMBER: This method **should** update cart
#   updated_cart = []
  
#   cart.each do |cart_item|
#     active_coupon = find_item_by_name_in_collection(cart_item[:item], coupons)
#     if active_coupon != nil
#       if cart_item[:count] >= active_coupon[:num]
#         num_items = active_coupon[:num]
        
#         # Create discount_item
#         discount_item = {
#           :item => cart_item[:item] + " W/COUPON",
#           :price => active_coupon[:cost] / num_items,
#           :clearance => cart_item[:clearance],
#           :count => active_coupon[:num]
#         }
        
#         # Add item with discount to updated cart
#         updated_cart << discount_item
        
#         # Update number of cart item after applying coupon
#         cart_item[:count] = cart_item[:count] - num_items
#         if cart_item[:count] > 0
#           cart_item << updated_cart
#         end
        
#       else
#         updated_cart << cart_item
#       end
#     else
#       updated_cart << cart_item
#     end
#   end

#   updated_cart
# end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] = cart_item[:price] * 0.8
    end
  end
end

def checkout(cart, coupons)
  
  consolidated_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

  checkout_total = 0
  consolidated_cart.each do |cart_item|
    checkout_total += cart_item[:price] * cart_item[:count]
  end

  if checkout_total >= 100
    checkout_total *= 0.9
  end
  
  checkout_total.round(2)
end