class FavoriteFoodsController < ApplicationController
  def index
    render json: FavoriteFood.find_favorites
  end
end
