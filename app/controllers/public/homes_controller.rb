class Public::HomesController < ApplicationController

  layout "public_application"

  def top
    @new_items = Item.all.order("created_at DESC").first(3)
  end

  def about
  end
end
