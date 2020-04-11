# frozen_string_literal: true

require 'dry-transformer'

module Brainbase
  module Transactions
    module Sessions
      class CreateSession
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include Import['contracts.sessions.create_session']
        include Import['repos.learner_repo']

        def call(input)
          credentials = yield validate(input)
          learner = yield find_learner(credentials[:email])
          yield authenticate(learner, credentials[:password])
          session = yield build_session(learner)

          Success(session)
        end

        private

        def build_session(learner)
          Success(
            JWTSessions::Session.new(
              payload: { learner_id: learner.id },
              access_claims: { aud: %w[web password] }
            ).login
          )
        end

        def authenticate(learner, password)
          return Success() if learner.password == password

          Failure(:wrong_password)
        end

        def find_learner(email)
          learner = learner_repo.find_by_email(email)

          return Success(learner) if learner

          Failure(:learner_not_found)
        end

        def validate(input)
          create_session.call(input).to_monad
        end
      end
    end
  end
end
