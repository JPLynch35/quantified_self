require 'rails_helper'

describe Meal, type: :model do
  before :each do
    @food1 = Food.create(name: 'banana', calories: 150)
    @food2 = Food.create(name: 'apple', calories: 100)
    @food3 = Food.create(name: 'toast', calories: 75)
    @food4 = Food.create(name: 'strawberries', calories: 200)
  end

  it 'exists' do
    meal = Meal.create(name: 'breakfast', foods: [@food1])

    expect(meal).to be_a(Meal)
  end

  describe 'relationships' do
    it { should have_many(:meal_foods) }
    it { should have_many(:foods).through(:meal_foods) }
  end
  
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
