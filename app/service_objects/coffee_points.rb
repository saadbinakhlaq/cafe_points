class CoffeePoints
  class << self
    def fetch(latitude:, longitude:)
      response = MapboxAPI.new(
        latitude: latitude,
        longitude: longitude
      ).coffee_shops_data

      if response.first['features'].blank?
        []
      else
        data         = data_by_name_postcode(response)
        grouped_data = data.group_by { |h| h[:postcode] }
  
        grouped_data.map do |postcode, values|
          CoffeePoint.new(
            postcode: postcode,
            coffee_shops: values.map { |value| { name: value[:name] } }
          )
        end
      end
    end

    private

    def data_by_name_postcode(data)
      data.first['features'].map do |feature|
        {
          name: feature['place_name'],
          postcode: (feature['context'].find do |context| 
            context['id'].start_with?('postcode')
          end || no_postcode)['text']
        }
      end
    end
  
    def no_postcode
      { 'id' => 'no_postcode', 'text' => 'no_postcode_available' }
    end
  end
end