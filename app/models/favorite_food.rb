class FavoriteFood
  include ActiveModel::Serialization
  attr_reader :timesEaten, :foods

  def initialize(timeseaten, foods)
    @timesEaten = timeseaten
    @foods = foods
  end
end
