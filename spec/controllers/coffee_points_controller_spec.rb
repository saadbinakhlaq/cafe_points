require 'rails_helper'

RSpec.describe CoffeePointsController, type: :controller do

  describe "GET #index" do
    context 'when required params not present' do
      subject { get :index }

      it { should have_http_status(:bad_request) }
    end

    context 'when required params present' do
      context 'when required params are invalid' do
        subject { get :index, params: { latitude: 'x', longitude: 'y' } }

        it { should have_http_status(:unprocessable_entity) }
      end

      context 'when required params are valid' do
        let(:lat)      { '1' }
        let(:long)     { '1' }
        let(:postcode) { '1' }
        let(:name)     { 'name' }

        before do
          allow(CoffeePoints).to receive(:fetch).
            with(latitude: lat, longitude: long).
            and_return(
              [
                CoffeePoint.new(
                  postcode: postcode,
                  coffee_shops: [{name: name}]
                )
              ]
            )
        end

        subject { get :index, params: { latitude: '1', longitude: '1' } }

        it { should have_http_status(:ok) }

        it 'list of coffee points' do
          expected_response = {
            coffee_points: [
              { 
                postcode: postcode,
                coffee_shops: [{name: name}]
              }
            ]
          }.to_json
          subject

          expect(response.body).to eq(expected_response)
        end
        
      end
    end
  end

end
