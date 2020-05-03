# frozen_string_literal: true

class PieceSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :content

  has_many :children, serializer: PieceSerializer, record_type: :piece
  belongs_to :parent, serializer: PieceSerializer, record_type: :piece
end
