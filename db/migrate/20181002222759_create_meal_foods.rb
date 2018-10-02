class CreateMealFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_foods do |t|
      t.references :food
      t.references :meal
    end
  end
end
