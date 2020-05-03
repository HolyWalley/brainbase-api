# frozen_string_literal: true

class LearnerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :username
end
