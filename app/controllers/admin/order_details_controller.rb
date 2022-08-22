class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      if @order.order_details.any?{|order_detail| order_detail.making_status == "製作中"}
        @order.update(status: "製作中")
      end
      if @order.order_details.all?{|order_detail| order_detail.making_status == "製作完了"}
        @order.update(status: "発送準備中")
      end
      redirect_to admin_order_path(@order_detail.order), notice: "製作ステータスを変更しました"
    else
      render admin_order_path, notice: "製作ステータスの変更が保存されませんでした"
    end
  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
