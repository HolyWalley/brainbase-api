# frozen_string_literal: true

module Tokens
  class CreateToken < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    option :learner_repo, default: proc { Learner }
    option :build_payload, default: proc { BuildPayload.new }

    def call(email:, password:)
      learner = yield find_learner(email)
      yield authentificate(learner, password)
      token = yield create_token(learner)

      Success(token)
    end

    private

    def find_learner(email)
      learner = learner_repo.find_by(email: email)

      return Failure(:not_found) unless learner

      Success(learner)
    end

    def authentificate(learner, password)
      return Failure(:unauthorized) unless learner.password == password

      Success()
    end

    def create_token(learner)
      payload = build_payload.call(learner: learner).success

      session = JWTSessions::Session.new(
        payload: payload, refresh_payload: { learner_id: learner.id }
      )

      Success(session.login)
    end
  end
end
