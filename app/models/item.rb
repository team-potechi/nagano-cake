class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  validates :name, presence:true
  validates :introduction, presence:true
  validates :price, presence:true
  validates :sale_status, inclusion: {in: [true, false] }

  has_one_attached :item_image

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end

  def add_tax_price
    (self.price*1.10).round
  end
end
