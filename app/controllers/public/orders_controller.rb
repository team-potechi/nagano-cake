class Public::OrdersController < ApplicationController

  layout "public_application"

  before_action :authenticate_customer!



  def new
    @order = Order.new
  end

  def confirm
    @customer = current_customer
    @cart_total = cart_total
    @shipping_cost = shipping_cost
    @total_payment = @cart_total + @shipping_cost
    @confirm_payment_method = params[:order][:payment_method]

    if params[:order][:select_address] == "ご自身の住所"
      @selected_address = Address.create(customer_id:current_customer,name:current_customer.lastname + current_customer.firstname,postal_code:current_customer.postal_code,address:current_customer.address)
    elsif params[:order][:select_address] == "登録済み住所から選択"
      @selected_address = Address.find(params[:order][:address_id])
    elsif params[:order][:select_address] == "新しいお届け先"
      @selected_address = Address.create(customer_id:current_customer,name:params[:order][:new_shipping_name],postal_code:params[:order][:new_postal_code],address:params[:order][:new_address])
    end

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.total_payment = cart_total + shipping_cost
    @order.customer_id = current_customer.id
    @order.shipping_cost = shipping_cost
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.tax_price = cart_item.cart_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  def cart_total
    cart_total = 0
    current_customer.cart_items.each do |cart_item|
      cart_total += cart_item.cart_subtotal
    end
    return cart_total
  end

  def shipping_cost
    shipping_cost = 800
  end





  private

  def order_params
    params.require(:order).permit(:payment_method,:select_address,:address_id,:new_postal_code,:new_address,:new_shipping_name,:postal_code,:address,:shipping_name)
  end


end
