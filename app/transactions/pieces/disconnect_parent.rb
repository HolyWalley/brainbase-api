# frozen_string_literal: true

module Pieces
  class DisconnectParent < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    def call(learner:, piece_id:, parent_id:)
      piece = yield find_piece(learner, piece_id)
      parent = yield find_parent_connection(piece, parent_id)
      yield destroy_parent_connection(parent)

      Success()
    end

    private

    def make_piece_root(piece)
      Success(piece.update!(root: true))
    end

    def destroy_parent_connection(connection)
      connection.destroy!

      Success()
    end

    def find_parent_connection(piece, parent_id)
      connection = piece.parents_connections.find_by!(parent_id: parent_id)

      Success(connection)
    end

    def find_piece(learner, piece_id)
      Success(learner.pieces.find(piece_id))
    end
  end
end
