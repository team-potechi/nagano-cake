class Admin::GenresController < ApplicationController
  layout 'admin_application'

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "ジャンルを追加できませんでした"
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンル名を変更しました"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      flash[:notice] = "ジャンル名を変更できませんでした"
      render :index
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
