class MealFood < ApplicationRecord
  validates_presence_of :meal_id, :food_id
  belongs_to :meal
  belongs_to :food
  
end
