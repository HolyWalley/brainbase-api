# frozen_string_literal: true

Brainbase::Application.boot(:web) do |app|
  init do
    require 'hanami-router'
    require 'hanami-controller'
    require 'jwt_sessions'
    require_relative app.root + 'lib/brainbase/web/controllers/authentication.rb'
  end

  start do
    JWTSessions.token_store = :redis, { redis_url: ENV['REDIS_URL'] }
    JWTSessions.encryption_key = ENV['SESSION_SECRET']
    JWTSessions.access_exp_time = 3600
    JWTSessions.refresh_exp_time = 604800
    JWTSessions.access_header = 'authorization'
    JWTSessions.refresh_header = 'x_refresh_token'

    Hanami::Controller.configure do
      format custom: 'application/json'
      default_request_format  :json
      default_response_format :json

      prepare do
        include Brainbase::Web::Controllers::Authentication
      end
    end
  end
end
