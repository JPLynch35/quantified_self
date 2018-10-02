require 'rails_helper'

describe Food, type: :model do
  it 'exists' do
    food = Food.create(name: 'banana', calories: 150)

    expect(food).to be_a(Food)
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:calories) }
  end
end
