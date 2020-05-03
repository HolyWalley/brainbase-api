# frozen_string_literal: true

class PiecesConnection < ApplicationRecord
  belongs_to :learner

  belongs_to :parent, class_name: "Piece"
  belongs_to :child, class_name: "Piece"
end
