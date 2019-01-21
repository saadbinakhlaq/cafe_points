class CoffeePoint
  include ActiveModel::Serialization

  attr_accessor :postcode, :coffee_shops

  def initialize(postcode:, coffee_shops:)
    @postcode     = postcode
    @coffee_shops = coffee_shops
  end
end