class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  has_one_attached :item_image

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end

  def status
    if self.sale_status == true
      "販売中"
    elsif self.sale_status == false
      "販売停止中"
    end
  end
end
