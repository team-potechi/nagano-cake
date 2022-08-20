class Public::ItemsController < ApplicationController

  layout "public_application"

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

end
