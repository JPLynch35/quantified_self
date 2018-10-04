require 'rails_helper'

describe Food, type: :model do
  it 'exists' do
    food = Food.create(name: 'banana', calories: 150)

    expect(food).to be_a(Food)
  end

  describe 'relationships' do
    it { should have_many(:meal_foods) }
    it { should have_many(:meals).through(:meal_foods) }
  end
  
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:calories) }
  end

  describe 'class methods' do
    it 'can find the top foods based on times eaten' do
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

      expected = 

      expect(Food.favorites.count).to eq(2)
      expect(Food.favorites.first.timesEaten).to eq(3)
      expect(Food.favorites.first.foods.count).to eq(1)
      expect(Food.favorites.first.foods.first.name).to eq('apple')
      expect(Food.favorites.last.timesEaten).to eq(2)
      expect(Food.favorites.last.foods.count).to eq(2)
      expect(Food.favorites.last.foods.first.name).to eq('strawberries')
      expect(Food.favorites.last.foods.last.name).to eq('banana')
    end
  end
end
