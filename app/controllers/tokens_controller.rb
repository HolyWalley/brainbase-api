# frozen_string_literal: true

class TokensController < ApplicationController
  schema(:create) do
    required(:email).value(:string)
    required(:password).value(:string)
  end

  skip_before_action :authorize_by_access_header!
  before_action :authorize_by_refresh_header!, only: :refresh

  def create
    case resolve("tokens.create_token").(**safe_params.to_h)
    in Success(token)
      render json: token
    in Failure(_reason)
      head 403
    end
  end

  def refresh
    case resolve("tokens.refresh_token").(token: found_token, payload: payload)
    in Success(token)
      render json: token
    in Failure(_reason)
      head 403
    end
  end
end
