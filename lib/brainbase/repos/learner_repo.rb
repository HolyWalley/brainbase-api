# frozen_string_literal: true

module Brainbase
  module Repos
    class LearnerRepo < ROM::Repository[:learners]
      include Import['container']

      struct_namespace Brainbase

      commands :create,
               use: :timestamps,
               plugins_options: {
                 timestamps: {
                   timestamps: %i[created_at updated_at]
                 }
               }

      def all
        learners.to_a
      end

      def find_by_email(email)
        learners.where(email: email).one
      end
    end
  end
end
