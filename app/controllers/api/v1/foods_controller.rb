class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    food = Food.create(name: params[:name], calories: params[:calories])
    if food.save
      render json: food
    end
  end
end
