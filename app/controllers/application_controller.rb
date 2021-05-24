class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def bad_params(message)
    body = ({
      error: "#{message}",
      status: 404
      }).to_json
    render json: JSON.parse(body, :quirks_mode => true), status: 404
  end

  def record_not_found(message)
    bad_params(message)
  end
end
