class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  layout "admin_application"

  def top
    @orders = Order.order("created_at DESC").page(params[:page]).per(10)
  end

end
