class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }


  def buy_total
    buy_total = 0
    self.order_details.each do |order_detail|
      buy_total += order_detail.subtotal.to_i
    end
    return buy_total
  end

  def order_items_id
    order_items_id = []
    self.order_details.each do |detail|
      order_items_id.push(detail.item_id)
    end
    return order_items_id
  end


end
