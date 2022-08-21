class Public::HomesController < ApplicationController

  layout "public_application"

  def top
    @new_items = Item.all.order("created_at DESC").first(4)
    @genres = Genre.all
  end

  def about
  end
end
