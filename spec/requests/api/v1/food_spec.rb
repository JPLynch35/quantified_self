require 'rails_helper'

describe 'Food API' do
  before :each do
    Food.create(name: 'banana', calories: 150)
    Food.create(name: 'apple', calories: 100)
    Food.create(name: 'toast', calories: 75)
    Food.create(name: 'strawberries', calories: 200)
  end
  context 'GET /api/v1/foods' do
    it 'returns a list of all foods' do
      get '/api/v1/foods'

      expect(response).to be_successful

      foods = JSON.parse(response.body, symbolize_names: true)
      food = foods.first

      expect(foods.count).to eq(4)
      expect(food[:name]).to eq('banana')
      expect(food[:calories]).to eq(150)
    end
  end
  context 'GET /api/v1/foods/:id' do
    it 'returns the food with corresponding id' do
      get '/api/v1/foods/2'

      expect(response).to be_successful

      food = JSON.parse(response.body, symbolize_names: true)

      expect(food[:name]).to eq('apple')
      expect(food[:calories]).to eq(100)
    end
  end
  context 'POST /api/v1/foods' do
    it 'creates a food' do
      json_payload = {name: 'salad', calories: 50}
      post '/api/v1/foods', params: json_payload

      expect(response).to be_successful

      food = JSON.parse(response.body, symbolize_names: true)

      expect(food[:name]).to eq('salad')
      expect(food[:calories]).to eq(50)
    end
  end
end
