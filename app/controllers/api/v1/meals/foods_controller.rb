class Api::V1::Meals::FoodsController < ApplicationController
  def index
    food = Meal.includes(:foods).find_by(id: params[:meal_id])
    if !!food
      render json: food.foods
    else
      render status: 404
    end
  end
end
