# frozen_string_literal: true

ENV['APP_ENV'] ||= 'test'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before do
    DatabaseCleaner.clean
  end
end

require_relative '../config/application'
Brainbase::Application.finalize!

require 'database_cleaner/sequel'
DatabaseCleaner.strategy = :truncation

require 'rom-factory'

Factory = ROM::Factory.configure do |config|
  config.rom = Brainbase::Application['container']
end

Dir[
  File.dirname(__FILE__) + '/support/factories/*.rb'
].sort.each { |file| require file }
