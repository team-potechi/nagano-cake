class OrderDetail < ApplicationRecord

  belongs_to :order_params
  belongs_to :item


  enum status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }


  def subtotal
    tax_price * amount
  end

end
