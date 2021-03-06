class Api::V1::Meals::FoodsController < ApplicationController
  def index
    food = Meal.includes(:foods).find_by(id: params[:meal_id])
    if !!food
      render json: food.foods
    else
      render status: 404
    end
  end

  def create
    if !!check_for_id
      meal = Meal.find(params[:meal_id])
      food = Food.find(params[:id])
      MealFood.create(meal_id: meal.id, food_id: food.id)
      render status: 201, json: {message: "Successfully added #{food.name} to #{meal.name}"}
    else
      render status: 404
    end
  end

  def destroy
    if !!check_for_id
      meal = Meal.find(params[:meal_id])
      food = Food.find(params[:id])
      MealFood.where(meal_id: meal.id, food_id: food.id).destroy_all
      render json: {message: "Successfully removed #{food.name} to #{meal.name}"}
    else
      render status: 404
    end
  end
  
  private

  def check_for_id
    Meal.find_by(id: params[:meal_id]) && Food.find_by(id: params[:id])
  end
end
