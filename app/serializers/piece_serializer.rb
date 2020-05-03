# frozen_string_literal: true

class PieceSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :content, :root

  has_many :children, serializer: PieceSerializer
  has_many :parents, serializer: PieceSerializer
end
