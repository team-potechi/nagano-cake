class Admin::OrderDetailsController < ApplicationController

  layout "admin_application"

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to order_path(@order_detail.order), notice: "製作ステータスを変更しました"
    else
      render order_path, notice: "製作ステータスの変更が保存されませんでした"
    end
  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
