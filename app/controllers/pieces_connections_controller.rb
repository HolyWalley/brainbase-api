# frozen_string_literal: true

class PiecesConnectionsController < ApplicationController
  schema(:create) do
    required(:pieces_connection).hash do
      required(:child_id).value(:integer)
      required(:parent_id).value(:integer)
    end
  end

  def create
    result = resolve("pieces_connections.create_pieces_connection").(
      learner: current_learner, **safe_params[:pieces_connection]
    )

    case result
    in Success(connection)
      render json: PiecesConnectionSerializer.new(connection)
    end
  end
end
