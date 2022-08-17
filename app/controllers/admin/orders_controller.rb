class Admin::OrdersController < ApplicationController

  layout "admin_application"

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to order_path(@order), notice: "注文ステータスを変更しました"
    else
      render "show", notice: "注文ステータスの変更が保存されませんでした"
    end
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
