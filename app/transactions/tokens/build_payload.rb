# frozen_string_literal: true

module Tokens
  class BuildPayload < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    def call(learner:)
      payload = yield build(learner)

      Success(payload)
    end

    private

    def build(learner)
      Success({
        learner_id: learner.id
      })
    end
  end
end
