require 'rails_helper'

describe MealFood, type: :model do
  it 'exists' do
    meal_food = MealFood.create(meal_id: 1, food_id: 1)

    expect(meal_food).to be_a(MealFood)
  end
  describe 'validations' do
    it { should validate_presence_of(:meal_id) }
    it { should validate_presence_of(:food_id) }
  end

  describe 'relationships' do
    it { should belong_to(:food) }
    it { should belong_to(:meal) }
  end
end
