class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"




  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      if @order.status == "入金待ち"
        @order_details.update_all(making_status: "着手不可")
      elsif @order.status == "入金確認"
        @order_details.update_all(making_status: "製作待ち")
      end
      redirect_to admin_order_path(@order), notice: "注文ステータスを変更しました"
    else
      render "show", notice: "注文ステータスの変更が保存されませんでした"
    end
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
