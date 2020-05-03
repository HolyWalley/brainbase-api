# frozen_string_literal: true

module Pieces
  class CreatePiece < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    def call(learner:, **params)
      piece = yield create(learner, params)

      Success(piece)
    end

    private

    def create(learner, params)
      piece = learner.pieces.create!(params)

      Success(piece)
    end
  end
end
