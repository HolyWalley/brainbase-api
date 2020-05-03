# frozen_string_literal: true

class PiecesConnectionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id

  belongs_to :parent, serializer: PieceSerializer
  belongs_to :child, serializer: PieceSerializer
end
