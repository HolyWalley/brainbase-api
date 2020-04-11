# frozen_string_literal: true

module Brainbase
  module Contracts
    module Sessions
      class CreateSession < ApplicationContract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end
      end
    end
  end
end
