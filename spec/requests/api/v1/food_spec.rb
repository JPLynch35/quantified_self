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
    it 'returns 404 if it cant find the food with corresponding id' do
      get '/api/v1/foods/7'

      expect(response.status).to eq(404)
    end
  end
  context 'POST /api/v1/foods' do
    it 'creates a food' do
      json_payload = { "food": {name: 'salad', calories: 50} }
      post '/api/v1/foods', params: json_payload

      expect(response).to be_successful

      food = JSON.parse(response.body, symbolize_names: true)

      expect(food[:name]).to eq('salad')
      expect(food[:calories]).to eq(50)
      expect(Food.last[:name]).to eq('salad')
      expect(Food.last[:calories]).to eq(50)
    end
    it 'returns 400 if it cant create a food' do
      json_payload = { "food": {calories: 50} }
      post '/api/v1/foods', params: json_payload

      expect(response.status).to eq(400)
    end
  end
  context 'PATCH /api/v1/foods/:id' do
    it 'updates a food' do
      expect(Food.find(3)[:name]).to eq('toast')
      expect(Food.find(3)[:calories]).to eq(75)

      json_payload = { "food": {name: 'toast', calories: 150} }
      patch '/api/v1/foods/3', params: json_payload

      expect(response).to be_successful

      food = JSON.parse(response.body, symbolize_names: true)

      expect(food[:name]).to eq('toast')
      expect(food[:calories]).to eq(150)
      expect(Food.find(3)[:name]).to eq('toast')
      expect(Food.find(3)[:calories]).to eq(150)
    end
    it 'returns 400 if it cant update a food' do
      json_payload = { "food": {calories: 150} }
      patch '/api/v1/foods/3', params: json_payload

      expect(response.status).to eq(400)
    end
  end
  context 'DELETE /api/v1/foods/:id' do
    it 'deletes a food' do
      delete '/api/v1/foods/3'

      expect(response).to be_successful
      expect(response.status).to eq(204)

      expect(Food.all.count).to eq(3)
    end
    it 'returns 404 if it cant delete a food' do
      delete '/api/v1/foods/7'

      expect(response.status).to eq(404)

      expect(Food.all.count).to eq(4)
    end
  end
end
