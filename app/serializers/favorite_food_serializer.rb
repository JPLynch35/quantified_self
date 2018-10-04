class FavoriteFoodSerializer < ActiveModel::Serializer
  attributes :timesEaten, :foods

  def foods
    object.foods.map do |food|
      {
        "name": food.name,
        "calories": food.calories,
        "mealsWhenEaten": 
          food.meals.map do |meal|
            meal.name
          end
      }
    end
  end
end
