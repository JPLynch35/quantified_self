require 'rails_helper'

describe FavoriteFood, type: :model do
  it 'exists' do
    food = Food.create(name: 'banana', calories: 150)
    favorite_food = FavoriteFood.new(4, [food])

    expect(favorite_food).to be_a(FavoriteFood)
  end
end
