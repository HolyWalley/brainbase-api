# frozen_string_literal: true

module Brainbase
  module Contracts
    class ApplicationContract < Dry::Validation::Contract
      register_macro(:email_format) do
        unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
          key.failure('not a valid email format')
        end
      end
    end
  end
end
