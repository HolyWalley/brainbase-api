# frozen_string_literal: true

RSpec.describe Brainbase::Web::Controllers::Authentication do
  let(:dummy_action) do
    Class.new do
      include Hanami::Action
      include Brainbase::Web::Controllers::Authentication

      def call(_params)
        'success'
      end
    end
  end

  context 'when token does not exist' do
    it 'rejects with 401' do
      expect(
        dummy_action.new.call('HTTP_AUTHORIZATION' => 'Bearer random')[0]
      ).to eq(401)
    end
  end

  context 'when token exists and match' do
    let(:session) { JWTSessions::Session.new(payload: { learner_id: 1 }).login }

    it 'performs action and return 200' do
      expect(
        dummy_action.new.call('HTTP_AUTHORIZATION' => session.fetch(:access))[0]
      ).to eq(200)
    end
  end
end
