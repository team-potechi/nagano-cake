class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  private

  def customer_params
    params.require(:customer).permit(:lastname, :firstname, :kana_lastname, :kana_firstname, :postal_code, :address, :tel, :email)
  end
end
