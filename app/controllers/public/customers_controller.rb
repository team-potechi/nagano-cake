class Public::CustomersController < ApplicationController

  layout "public_application"

  def show
    @customer = current_customer
  end

  def confirm
    @customer = current_customer
  end

  def deleted
    @customer = current_customer
    @customer.update(is_deleted: true)
    flash[:notice] = "退会処理を実行いたしました"
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:lastname, :firstname, :kana_lastname, :kana_firstname, :postal_code, :address, :tel, :email, :password)
  end
end
