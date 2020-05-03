# frozen_string_literal: true

module Learners
  class CreateLearner < ApplicationTransaction
    include Dry::Monads::Do.for(:call)

    def call(params)
      yield validate_email_uniqueness(params.fetch(:email))
      yield validate_username_uniqueness(params.fetch(:username))

      learner = yield create_learner(params)

      Success(learner)
    end

    private

    def validate_email_uniqueness(email)
      return Success() unless learner_repo.find_by(email: email)

      Failure(:email_has_already_been_taken)
    end

    def validate_username_uniqueness(username)
      return Success() unless learner_repo.find_by(username: username)

      Failure(:username_has_already_been_taken)
    end

    def create_learner(params)
      learner = learner_repo.new(params)

      learner.save!

      Success(learner)
    end

    def learner_repo
      Learner
    end
  end
end
