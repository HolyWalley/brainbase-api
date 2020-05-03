# frozen_string_literal: true

module PiecesConnections
  class CreatePiecesConnection < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    def call(learner:, **params)
      connection = yield create(learner, params)

      Success(connection)
    end

    private

    def create(learner, params)
      Success(learner.pieces_connections.create!(params))
    end
  end
end
