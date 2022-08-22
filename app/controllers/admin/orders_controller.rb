class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"




  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
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
