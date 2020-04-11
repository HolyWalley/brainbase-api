# frozen_string_literal: true

module Brainbase
  module Relations
    class Learners < ROM::Relation[:sql]
      schema(:learners, infer: true)
    end
  end
end
