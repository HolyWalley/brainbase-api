# frozen_string_literal: true

class PiecesController < ApplicationController
  schema(:create, :update) do
    required(:piece).hash do
      required(:name).value(:string)
      optional(:content).value(:string)
      optional(:parent_id).value(:integer)
    end
  end

  def create
    case resolve("pieces.create_piece").(
      learner: current_learner, **safe_params[:piece]
    )
    in Success(piece)
      render json: PieceSerializer.new(piece)
    end
  end

  # TODO: move to transaction
  def update
    piece = current_learner.pieces.find(params[:id])

    if piece.update(safe_params[:piece])
      render json: PieceSerializer.new(piece)
    else
      render json: { errors: [piece.errors.to_h] }
    end
  end

  # TODO: add filtering
  def index
    pieces = current_learner.pieces.root.preload_x_levels(3)

    render(
      json: PieceSerializer.new(
        pieces,
        include: 1.upto(3).map { |i| i.times.map { "children" }.join(".").to_sym }
      )
    )
  end

  # TODO
  def duplicate
  end

  private

  def piece_serializer
    PieceSerializer
  end
end
