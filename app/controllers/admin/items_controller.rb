class Admin::ItemsController < ApplicationController

  layout 'admin_application'

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "商品の登録ができませんでした"
      render :new
    end
  end

  def index
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :genre_id, :introduction, :price, :sale_status, :item_image)
  end

end