# frozen_string_literal: true

module Brainbase
  module Web
    module Controllers
      module Learners
        class Create
          include Hanami::Action
          include Import['transactions.learners.create_learner']
          include Dry::Monads[:result]

          def call(params)
            result = create_learner.call(params.to_h)
            case result
            in Success(learner)
              self.body = learner.to_h.to_json
              self.status = 200
            in Failure(Dry::Validation::Result)
              self.body = { errors: result.failure.errors.to_h }.to_json
              self.status = 422
            in Failure(:email_has_already_been_taken)
              self.body = { errors: { email: ['has already been taken'] } }.to_json
              self.status = 422
            end
          end

          private

          def authorize_by_access_header!; end
        end
      end
    end
  end
end
