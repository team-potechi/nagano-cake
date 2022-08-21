class Public::ItemsController < ApplicationController

  layout "public_application"

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def genre_items
    @genres = Genre.all
    @genre = Genre.find(params[:item_id])
    @genre_items = @genre.items.page(params[:page]).per(8)
  end

end
