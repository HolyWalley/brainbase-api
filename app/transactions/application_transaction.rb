# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"
require "dry-initializer"

class ApplicationTransaction
  include Dry::Monads[:result]
  extend Dry::Initializer
end
