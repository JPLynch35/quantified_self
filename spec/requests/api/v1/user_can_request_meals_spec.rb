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

  context 'GET /api/v1/meals/:meal_id/foods' do
    it 'returns a list of all foods associated with a meal' do
      get '/api/v1/meals/1/foods'

      expect(response).to be_successful

      foods = JSON.parse(response.body, symbolize_names: true)
      food = foods.first

      expect(foods.count).to eq(2)
      expect(food[:name]).to eq('banana')
      expect(food[:calories]).to eq(150)
    end
    it 'returns 404 if it cant find the meal with corresponding id' do
      get '/api/v1/meals/8/foods'

      expect(response.status).to eq(404)
    end
  end

  context 'POST /api/v1/meals/:meal_id/foods/:id' do
    it 'adds the food with :id to the associated meal' do
      expect(Meal.first.foods.count).to eq(2)

      post '/api/v1/meals/1/foods/4'

      expect(response).to be_successful

      expected =  {
                    "message": "Successfully added #{@food4.name} to #{@meal1.name}"
                  }
      receieved_response = JSON.parse(response.body, symbolize_names: true)

      expect(receieved_response).to eq(expected)
      expect(response.status).to eq(201)
      expect(Meal.first.foods.count).to eq(3)
    end
    it 'returns 404 if the meal cant be found' do
      post '/api/v1/meals/7/foods/2'

      expect(response.status).to eq(404)
    end
    it 'returns 404 if the food cant be found' do
      post '/api/v1/meals/1/foods/8'

      expect(response.status).to eq(404)
    end
  end

  context 'DELETE /api/v1/meals/:meal_id/foods/:id' do
    it 'deletes the food with :id to the associated meal' do
      expect(Meal.first.foods.count).to eq(2)

      delete '/api/v1/meals/1/foods/2'

      expect(response).to be_successful

      expected =  {
                    "message": "Successfully removed #{@food2.name} to #{@meal1.name}"
                  }
      receieved_response = JSON.parse(response.body, symbolize_names: true)

      expect(receieved_response).to eq(expected)
      expect(Meal.first.foods.count).to eq(1)
    end
    it 'returns 404 if the meal cant be found' do
      delete '/api/v1/meals/7/foods/2'

      expect(response.status).to eq(404)
    end
    it 'returns 404 if the food cant be found' do
      delete '/api/v1/meals/1/foods/8'

      expect(response.status).to eq(404)
    end
  end
end
