# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/sessions' do
  context 'POST /' do
    let(:input) do
      {
        email: 'john.doe@example.com',
        password: '12345678'
      }
    end

    context 'when user does not exist' do
      it 'failure' do
        post_json '/sessions', input
        expect(last_response.status).to eq(401)
      end
    end

    context 'when user exists with the other password' do
      before { Factory[:learner, email: input[:email]] }

      it 'failure' do
        post_json '/sessions', input
        expect(last_response.status).to eq(401)
      end
    end

    context 'when user exists' do
      before do
        Factory[
          :learner,
          email: input[:email],
          password_digest: BCrypt::Password.create(input[:password])
        ]
      end

      it 'success' do
        post_json '/sessions', input
        expect(last_response.status).to eq(200)
        session = parsed_body
        expect(session['access']).not_to be_nil
        expect(session['refresh']).not_to be_nil
      end
    end
  end
end
