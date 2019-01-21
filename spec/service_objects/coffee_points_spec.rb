require 'rails_helper'

RSpec.describe CoffeePoints do
  let(:latitude) { '1' }
  let(:longitude) { '1' }

  describe '.fetch' do
    subject do
      CoffeePoints.fetch(latitude: latitude, longitude: longitude)
    end

    it 'calls mapbox api with correct arguments' do
      mapbox_api = instance_double('MapboxAPI')
      allow(mapbox_api).to receive(:coffee_shops_data).and_return(
        [
          {
            'features': []
          },
          {}
        ]
      )
      expect(MapboxAPI).to receive(:new).with(latitude: latitude, longitude: longitude).
        and_return(mapbox_api)
      subject
    end

    context 'when mapbox service returns no features' do
      subject do
        CoffeePoints.fetch(latitude: latitude, longitude: longitude)
      end
  
      it 'returns empty array' do
        allow_any_instance_of(MapboxAPI).to receive(:coffee_shops_data).and_return(
          [
            {
              'features': []
            },
            {}
          ]
        )
  
        expect(subject).to eq([])
      end
    end
  
    context 'when mapbox service return features' do
      let(:coffee_shop_name)  { 'name' }
      let(:coffee_shop_postcode)  { '1' }

      it 'returns coffee points objects in array' do
        allow_any_instance_of(MapboxAPI).to receive(:coffee_shops_data).and_return(
          [
            {
              'features' => [
                {
                  'place_name' => coffee_shop_name,
                  'context' => [{ 'id' => 'postcode', 'text' => coffee_shop_postcode }]
                }
              ]
            },
            {}
          ]
        )
        result = CoffeePoints.fetch(latitude: latitude, longitude: longitude)
        coffee_point = result.first
        expect(coffee_point.postcode).to eq(coffee_shop_postcode)
        expect(coffee_point.coffee_shops).to eq([{ name: coffee_shop_name }])
      end
    end
  end
end