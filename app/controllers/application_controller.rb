class ApplicationController < ActionController::API

rescue_from MapboxAPI::ApiValidationError, with: :api_validation_error
  
  
  private

  def api_validation_error(exception)
    render json: {
      errors: [
        exception.message
      ]
    }, status: :unprocessable_entity
  end
end
