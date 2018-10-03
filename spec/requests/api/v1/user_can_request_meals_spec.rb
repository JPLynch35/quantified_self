require 'rails_helper'

describe 'Food API' do
  before :each do
    @food1 = Food.create(name: 'banana', calories: 150)
    @food2 = Food.create(name: 'apple', calories: 100)
    @food3 = Food.create(name: 'toast', calories: 75)
    @food4 = Food.create(name: 'strawberries', calories: 200)
    @meal1 = Meal.create(name: 'breakfast')
    @meal2 = Meal.create(name: 'lunch')
    @meal1.meal_foods.create(food_id: 1)
    @meal1.meal_foods.create(food_id: 2)
    @meal2.meal_foods.create(food_id: 2)
    @meal2.meal_foods.create(food_id: 3)
    @meal2.meal_foods.create(food_id: 4)
  end

  context 'GET /api/v1/meals' do
    it 'returns a list of all meals with associated foods' do
      get '/api/v1/meals'

      expect(response).to be_successful

      meals = JSON.parse(response.body, symbolize_names: true)
      meal = meals.first

      expect(meals.count).to eq(2)
      expect(meal[:name]).to eq('breakfast')
      expect(meal[:foods].count).to eq(2)
      expect(meal[:foods].last[:name]).to eq('apple')
      expect(meal[:foods].last[:calories]).to eq(100)
    end
  end
end
