# frozen_string_literal: true

class TokensController < ApplicationController
  schema(:create) do
    required(:email).value(:string)
    required(:password).value(:string)
  end

  skip_before_action :authorize_access_request!
  before_action :authorize_refresh_request!, only: :refresh

  def create
    case resolve("tokens.create_token").(**safe_params.to_h)
    in Success(tokens)
      response.set_cookie(JWTSessions.access_cookie,
                          value:     tokens[:access],
                          httponly:  true,
                          same_site: :none,
                          secure:    Rails.env.production?)

      response.set_cookie(JWTSessions.refresh_cookie,
                          value:     tokens[:refresh],
                          httponly:  true,
                          same_site: :none,
                          secure:    Rails.env.production?)

      render json: tokens
    in Failure(_reason)
      head 403
    end
  end

  def refresh
    case resolve("tokens.refresh_token").(token: found_token, payload: payload)
    in Success(tokens)
      response.set_cookie(JWTSessions.access_cookie,
                          value:     tokens[:access],
                          httponly:  true,
                          same_site: :none,
                          secure:    Rails.env.production?)
      render json: tokens
    in Failure(_reason)
      head 403
    end
  end
end
