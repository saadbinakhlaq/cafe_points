require 'rails_helper'

RSpec.describe MapboxAPI do
  describe 'validations' do
    context 'latitude not valid' do
      subject do
        described_class.new(latitude:'a', longitude: '12.1')
      end

      it 'raise ApiValidationError' do
        expect do
          subject.coffee_shops_data
        end.to raise_error(MapboxAPI::ApiValidationError)
      end
    end

    context 'longitude not valid' do
      subject do
        described_class.new(latitude:'12.1', longitude: 'a')
      end

      it 'raise ApiValidationError' do
        expect do
          subject.coffee_shops_data
        end.to raise_error(MapboxAPI::ApiValidationError)
      end
    end

    context 'longitude is outside range' do
      subject do
        described_class.new(latitude:'1', longitude: '-212.1')
      end

      it 'raise ApiValidationError' do
        expect do
          subject.coffee_shops_data
        end.to raise_error(MapboxAPI::ApiValidationError)
      end
    end

    context 'latitude is outside range' do
      subject do
        described_class.new(latitude:'-111', longitude: '0.1')
      end

      it 'raise ApiValidationError' do
        expect do
          subject.coffee_shops_data
        end.to raise_error(MapboxAPI::ApiValidationError)
      end
    end
  end

  describe '#coffee_shops_data' do
    let(:latitude)  { '1' }
    let(:longitude) { '2' }

    subject do
      described_class.new(
        latitude:  latitude,
        longitude: longitude
      ).coffee_shops_data
    end

    it 'calls mapbox_sdk with correct params' do
      expect(Mapbox::Geocoder).to receive(:geocode_forward).with(
        MapboxAPI::QUERY,
        {
          proximity: {
            longitude: Float(longitude),
            latitude: Float(latitude)
          },
          types: [MapboxAPI::POI],
          limit: MapboxAPI::LIMIT
        }
      )

      subject
    end
  end
end