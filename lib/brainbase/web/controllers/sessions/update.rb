# frozen_string_literal: true

module Brainbase
  module Web
    module Controllers
      module Sessions
        class Update
          include Hanami::Action
          include Dry::Monads[:result]

          include Import['transactions.sessions.refresh_session']

          before :authorize_by_refresh_header!

          def call(params)
            case refresh_session.call(payload, found_token)
            in Success(session)
              self.body = session.to_json
              self.status = 200
            else
              self.status = 401
            end
          end

          private

          def authorize_by_refresh_header!
            super
          rescue JWTSessions::Errors::Unauthorized
            halt 401
          end

          def authorize_by_access_header!; end
        end
      end
    end
  end
end
