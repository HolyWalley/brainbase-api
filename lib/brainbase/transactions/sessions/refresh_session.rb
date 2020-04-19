# frozen_string_literal: true

require 'dry-transformer'

module Brainbase
  module Transactions
    module Sessions
      class RefreshSession
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        def call(payload, token)
          session = yield refresh_session(payload, token)

          Success(session)
        end

        private

        def refresh_session(payload, token)
          access_payload = { learner_id: payload[:learner_id] }

          Success(
            JWTSessions::Session.new(
              payload: access_payload,
              refresh_payload: payload,
              access_claims: { aud: %w[web password] }
            ).refresh(token)
          )
        end
      end
    end
  end
end
