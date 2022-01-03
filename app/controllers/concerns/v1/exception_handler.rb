module V1::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {
        message: 'your query could not be completed',
        error: { details: e.message }
      }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: {
        message: 'Invalid Record',
        error: { details: e.message }
      }, status: 400
    end
  end
end
