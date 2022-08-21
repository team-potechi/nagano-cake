class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :amount, presence:true


  def cart_tax_price
    (self.item.price * 1.1).floor
  end

  def cart_subtotal
    self.cart_tax_price * amount
  end


end
