require 'rails_helper'

describe 'Food API' do
  before :each do
    @food1 = Food.create(name: 'banana', calories: 150)
    @food2 = Food.create(name: 'apple', calories: 100)
    @food3 = Food.create(name: 'toast', calories: 75)
    @food4 = Food.create(name: 'strawberries', calories: 200)
    @meal1 = Meal.create(name: 'breakfast')
    @meal2 = Meal.create(name: 'lunch')
    @meal3 = Meal.create(name: 'dinner')
    @meal1.meal_foods.create(food_id: 1)
    @meal1.meal_foods.create(food_id: 2)
    @meal2.meal_foods.create(food_id: 2)
    @meal2.meal_foods.create(food_id: 3)
    @meal2.meal_foods.create(food_id: 4)
    @meal3.meal_foods.create(food_id: 1)
    @meal3.meal_foods.create(food_id: 2)
    @meal3.meal_foods.create(food_id: 4)
  end
  context 'GET /api/v1/favorite_foods' do
    it 'returns a list of the 3 foods eaten the most amount of times greater than 1' do
      get '/api/v1/favorite_foods'

      expect(response).to be_successful

      fav_foods = JSON.parse(response.body, symbolize_names: true)
      fav_food1 = fav_foods.first
      fav_food2 = fav_foods.last

      expect(fav_foods.count).to eq(2)
      expect(fav_food1[:timesEaten]).to eq(3)
      expect(fav_food1[:foods].count).to eq(1)
      expect(fav_food1[:foods].first[:name]).to eq('apple')
      expect(fav_food1[:foods].first[:calories]).to eq(100)
      expect(fav_food1[:foods].first[:mealsWhenEaten]).to eq([@meal1.name, @meal2.name, @meal3.name])
      expect(fav_food2[:timesEaten]).to eq(2)
      expect(fav_food2[:foods].count).to eq(2)
      expect(fav_food2[:foods].first[:name]).to eq('strawberries')
      expect(fav_food2[:foods].first[:calories]).to eq(200)
      expect(fav_food2[:foods].first[:mealsWhenEaten]).to eq([@meal2.name, @meal3.name])
      expect(fav_food2[:foods].last[:name]).to eq('banana')
      expect(fav_food2[:foods].last[:calories]).to eq(150)
      expect(fav_food2[:foods].last[:mealsWhenEaten]).to eq([@meal1.name, @meal3.name])
    end
  end
end
