class CoffeePointsController < ApplicationController
  before_action :check_query_params, only: :index

  def index
    coffee_points = CoffeePoints.fetch(latitude: latitude, longitude: longitude)

    render json: coffee_points, each_serializer: CoffeePointSerializer, root: 'coffee_points'
  end

  private

  def latitude
    params[:latitude]
  end

  def longitude
    params[:longitude]
  end

  def check_query_params
    if params[:latitude].nil? || params[:longitude].nil?
      render json: {
        errors: [
          "missing required params: latitude and longitude eg. (/coffee_points?latitude=xxx&longitude=yyy)"
        ]
      }, status: :bad_request
    end
  end
end
