# frozen_string_literal: true

module Brainbase
  module Web
    module Controllers
      module Sessions
        class Create
          include Hanami::Action
          include Dry::Monads[:result]

          include Import['transactions.sessions.create_session']

          def call(params)
            case create_session.call(params.to_h)
            in Failure
              self.status = 401
            in Success(session)
              self.body = session.to_json
              self.status = 200
            end
          end

          private

          def authorize_by_access_header!; end
        end
      end
    end
  end
end
