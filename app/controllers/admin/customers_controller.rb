class Admin::CustomersController < ApplicationController
  layout "admin_application"

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:lastname, :firstname, :kana_lastname, :kana_firstname, :postal_code, :address, :tel, :email, :password)
  end
end
