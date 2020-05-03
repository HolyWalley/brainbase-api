# frozen_string_literal: true

module Tokens
  class RefreshToken < ApplicationTransaction
    include Dry::Monads::Do.for(:call)
    include BrainbaseApi::Import["tokens.build_payload"]

    option :learner_repo, default: proc { Learner }

    def call(token:, payload:)
      learner = yield find_learner(payload)
      session = yield build_session(learner)
      new_token = yield refresh_token(session, token)

      Success(new_token)
    end

    private

    def find_learner(payload)
      Success(learner_repo.find(payload["learner_id"]))
    end

    def build_session(learner)
      case build_payload.(learner: learner)
      in Success(payload)
        Success(JWTSessions::Session.new(payload: payload))
      end
    end

    def refresh_token(session, token)
      Success(session.refresh(token))
    end
  end
end
