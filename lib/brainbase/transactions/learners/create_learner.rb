# frozen_string_literal: true

require 'dry-transformer'

module Brainbase
  module Transactions
    module Learners
      class CreateLearner
        module F
          extend Dry::Transformer::Registry

          import Dry::Transformer::HashTransformations
          import :create, from: BCrypt::Password, as: :encrypt
        end

        T = F[:rename_keys, password: :password_digest]
          .>> F[:map_value, :password_digest, -> { F[:encrypt][_1] }]

        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include Import['contracts.learners.create_learner']
        include Import['repos.learner_repo']

        def call(input)
          values = yield validate(input)
          yield validate_email(values[:email])
          params = yield transform(values)
          user   = yield persist(params)

          Success(user)
        end

        private

        def validate(input)
          create_learner.call(input).to_monad
        end

        def validate_email(email)
          return Success() unless learner_repo.find_by_email(email)

          Failure(:email_has_already_been_taken)
        end

        def transform(result)
          Success(T[result.values])
        end

        def persist(params)
          Success(learner_repo.create(params))
        end
      end
    end
  end
end
