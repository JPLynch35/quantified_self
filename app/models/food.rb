class Food < ApplicationRecord
  validates_presence_of :name, :calories
  has_many :meal_foods
  has_many :meals, through: :meal_foods

  def self.favorites
    favorite_foods = select('foods.*, COUNT(meal_foods.food_id) AS timesEaten')
      .joins(:meal_foods)
      .group(:id)
      .order('timesEaten desc')
    favorites_count = favorite_foods.group_by do |food|
      food.meals.count
    end
    favorites = favorites_count.map do |food_stats|
      FavoriteFood.new(food_stats.first, food_stats.last) if food_stats.first > 1
    end.compact
  end
end
