require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon|
    cart.each do |inner_cart|
      if inner_cart[:item] == coupon[:item] && inner_cart[:count] >= coupon[:num]
        inner_cart[:count] = inner_cart[:count] - coupon[:num]
        cart[cart.length()] = {
          :item => "#{inner_cart[:item]} W/COUPON",
          :price => coupon[:cost]/coupon[:num],
          :clearance => inner_cart[:clearance],
          :count => coupon[:num]
        }
      end
      #binding.pry
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  #output = []
  
  cart.each do |inner_cart|
    if inner_cart[:clearance]
      #output.push({
        #:item => inner_cart[:item],
        #:price => (inner_cart[:price]*0.8).round(2),
        #:clearance => inner_cart[:clearance],
        #:count => inner_cart[:count]
      #})
      inner_cart[:price] = (inner_cart[:price]*0.8).round(2)
    #else
      #output << inner_cart
    end
  end
  #binding.pry
  #output
  cart
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
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  #binding.pry
  total = 0
  
  cart.each do |inner_cart|
    total += (inner_cart[:count] * inner_cart[:price])
  end
  #binding.pry
  if total > 100
    total = (total * 0.90).round(2)
  end
  total
end
