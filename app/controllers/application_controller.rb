class ApplicationController < ActionController::API

rescue_from MapboxAPI::ApiValidationError, with: :api_errors
rescue_from MapboxAPI::ApiAuthenticationError, with: :api_errors
  
  
  private

  def api_errors(exception)
    render json: {
      errors: [
        exception.message
      ]
    }, status: :unprocessable_entity
  end
end
