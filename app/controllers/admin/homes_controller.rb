class Admin::HomesController < ApplicationController

  layout "admin_application"

  def top
    @orders = Order.order("created_at DESC").page(params[:page]).per(10)
  end

end
