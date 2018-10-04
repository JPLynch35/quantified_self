class Api::V1::FavoriteFoodsController < ApplicationController
  def index
    render json: Food.favorites, each_serializer: FavoriteFoodSerializer
  end
end
