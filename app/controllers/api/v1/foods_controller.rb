class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    if !!check_for_food_id
      render json: check_for_food_id
    else
      render status: 404
    end
  end

  def create
    food = Food.create(food_params)
    if food.save
      render json: food
    else
      render status: 400
    end
  end

  def update
    food = Food.find(params[:id])
    if food.update_attributes(food_params) && food_params[:name] && food_params[:calories]
      render json: food
    else
      render status: 400
    end
  end

  def destroy
    if !!check_for_food_id
      check_for_food_id.destroy
      render status: 204
    else
      render status: 404
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories)
  end

  def check_for_food_id
    Food.find_by(id: params[:id])
  end
end
