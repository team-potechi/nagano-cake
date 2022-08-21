class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  layout "public_application"

  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_total = cart_total
    @cart_item = CartItem.new
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "商品数を変更しました"
    else
      render "index", notice: "商品数の変更が保存されませんでした"
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    @new_cart_item = CartItem.new(cart_item_params)
    if params[:cart_item][:amount] == ""
      flash[:notice] = "商品の登録に失敗しました"
      @item = Item.find(params[:cart_item][:item_id])
      @genres = Genre.all
      @cart_item = CartItem.new
      redirect_to item_path(params[:cart_item][:item_id])
    else @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      if @cart_item.present?
        @cart_item.amount += params[:cart_item][:amount].to_i
        @cart_item.save
        redirect_to cart_items_path
      else
        @new_cart_item.customer_id = current_customer.id
        if @new_cart_item.save
          redirect_to cart_items_path
        else
          redirect_to request.referer
        end
      end
    end
  end



  def cart_total
    cart_total = 0
    current_customer.cart_items.each do |cart_item|
      cart_total += cart_item.cart_subtotal
    end
    return cart_total
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
