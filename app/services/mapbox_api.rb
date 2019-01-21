class MapboxAPI
  QUERY = 'coffee'.freeze
  POI   = 'poi'.freeze
  LIMIT = 20

  class ApiValidationError < StandardError;end

  def initialize(latitude:, longitude:)
    @latitude  = latitude
    @longitude = longitude
    Mapbox.access_token = Rails.application.secrets.mapbox_api_key
  end

  def coffee_shops_data
    response = Mapbox::Geocoder.geocode_forward(
      QUERY,
      {
        proximity: {
          longitude: longitude,
          latitude: latitude
        },
        types: [POI],
        limit: LIMIT
      }
    )
  end

  private

  def latitude
    value = Float(@latitude)

    if value > 90 || value < -90
      raise ApiValidationError.new("latitude: #{@latitude} should be between -90 to +90")
    else
      value
    end
  rescue ArgumentError
    raise ApiValidationError.new("latitude: #{@latitude} is not a valid")
  end

  def longitude
    value = Float(@longitude)

    if value > 180 || value < -180
      raise ApiValidationError.new("longitude: #{@longitude} should be between -90 to +90")
    else
      value
    end
  rescue ArgumentError
    raise ApiValidationError.new("longitude: #{@longitude} is not a valid")
  end
end