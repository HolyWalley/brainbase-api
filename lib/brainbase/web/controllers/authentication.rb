# frozen_string_literal: true

module Brainbase
  module Web
    module Controllers
      module Authentication
        include JWTSessions::Authorization

        def self.included(action)
          action.class_eval do
            before :authorize_by_access_header!
          end
        end

        def request_headers
          request.env.each_with_object({}) do |(k, v), h|
            h[Regexp.last_match(1).downcase] = v if k =~ /^http_(.*)/i
          end
        end

        def request_method
          request.request_method
        end

        def authorize_by_access_header!
          super
        rescue JWTSessions::Errors::Unauthorized
          halt 401
        end
      end
    end
  end
end
