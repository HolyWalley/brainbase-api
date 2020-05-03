# frozen_string_literal: true

class Piece < ApplicationRecord
  belongs_to :learner
  belongs_to :parent, optional: true

  has_many :children, class_name: "Piece", foreign_key: :parent_id

  scope :preload_x_levels, lambda { |x|
    includes((x - 1).times.inject(:children) { { children: _1 } })
  }

  scope :root, -> { where(parent_id: nil) }
end
