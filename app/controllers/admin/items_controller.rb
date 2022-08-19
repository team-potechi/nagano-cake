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
      flash[:notice] = "商品の登録に失敗しました"
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品登録情報を変更しました"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "商品登録情報の変更に失敗しました"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :genre_id, :introduction, :price, :sale_status, :item_image)
  end

end