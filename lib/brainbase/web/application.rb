# frozen_string_literal: true

require 'hanami/middleware/body_parser'

module Brainbase
  module Web
    def self.app
      Rack::Builder.new do
        use Hanami::Middleware::BodyParser, :json
        run Brainbase::Web::Router
      end
    end
  end
end
