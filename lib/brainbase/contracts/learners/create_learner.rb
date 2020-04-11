# frozen_string_literal: true

module Brainbase
  module Contracts
    module Learners
      class CreateLearner < ApplicationContract
        params do
          required(:nick_name).filled(:string)
          required(:email).filled(:string)
          required(:password).filled(:string).value(min_size?: 8)

          optional(:city).filled(:string)
          optional(:first_name).filled(:string)
          optional(:last_name).filled(:string)
          optional(:age).filled(:integer)
        end

        rule(:email).validate(:email_format)
      end
    end
  end
end
