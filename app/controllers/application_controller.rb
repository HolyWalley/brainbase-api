# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Dry::Monads[:result]
  include JWTSessions::RailsAuthorization

  before_action :authorize_by_access_header!, prepend: true

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  def validate_params
    return unless safe_params&.failure?

    render json: { errors: safe_params.errors.to_h }, status: 422
  end

  def not_authorized
    render status: :unauthorized
  end

  def current_learner
    @current_learner ||= Learner.find(payload['learner_id'])
  end
end
