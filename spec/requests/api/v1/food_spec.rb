require 'rails_helper'

describe 'Food API' do
  context 'GET /api/v1/foods' do
    before :each do
      Food.create(name: 'banana', calories: 150)
      Food.create(name: 'apple', calories: 100)
      Food.create(name: 'toast', calories: 75)
      Food.create(name: 'strawberries', calories: 200)
    end
    it 'returns a list of all foods' do
      get '/api/v1/foods'

      expect(response).to be_successful

      foods = JSON.parse(response.body, symbolize_names: true)
      food = foods.first

      expect(foods.count).to eq(4)
      expect(food).to have_key(:name)
      expect(food).to have_key(:calories)
    end
  end
end
