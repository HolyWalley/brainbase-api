# frozen_string_literal: true

class Piece < ApplicationRecord
  belongs_to :learner

  has_many :children_connections,
           class_name:  "PiecesConnection",
           foreign_key: :parent_id,
           autosave:    true

  has_many :parents_connections,
           class_name:  "PiecesConnection",
           foreign_key: :child_id,
           autosave:    true

  has_many :children, through: :children_connections, source: :child
  has_many :parents, through: :parents_connections, source: :parent

  scope :preload_x_levels, lambda { |x|
    includes((x - 1).times.inject(:children) do |obj, _|
      obj = { children: obj }
      obj
    end)
  }

  scope :root, -> { where(root: true) }

  def add_parent(parent)
    parents_connections.build(parent: parent, child: self)

    self
  end
end
