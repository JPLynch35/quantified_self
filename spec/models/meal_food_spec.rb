require 'rails_helper'

describe MealFood, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:meal_id) }
    it { should validate_presence_of(:food_id) }
  end

  describe 'relationships' do
    it { should belong_to(:food) }
    it { should belong_to(:meal) }
  end
end
