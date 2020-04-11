# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/learners' do
  context 'POST /' do
    context 'with valid input' do
      let(:input) do
        {
          email: 'john.doe@example.com',
          password: '12345678',
          nick_name: 'johndoe',
          first_name: 'John',
          last_name: 'Doe',
          age: rand(18..65)
        }
      end

      it 'succeeds' do
        post_json '/learners', input
        expect(last_response.status).to eq(200)
        learner = parsed_body
        expect(learner['id']).not_to be_nil
        expect(learner['password_digest']).not_to be_nil
        expect(learner['first_name']).to eq(input[:first_name])
        expect(learner['last_name']).to eq(input[:last_name])
        expect(learner['nick_name']).to eq(input[:nick_name])
        expect(learner['age']).to eq(input[:age])
      end
    end

    context 'with invalid input' do
      let(:input) { { age: rand(18..65) } }

      it 'returns an error' do
        post_json '/learners', input
        expect(last_response.status).to eq(422)
        learner = parsed_body
        expect(learner['errors']['nick_name']).to include('is missing')
        expect(learner['errors']['email']).to include('is missing')
        expect(learner['errors']['password']).to include('is missing')
      end
    end

    context 'when email has already been taken' do
      let(:input) do
        {
          email: 'john.doe@example.com',
          password: '12345678',
          nick_name: 'johndoe',
          first_name: 'John',
          last_name: 'Doe',
          age: rand(18..65)
        }
      end

      before { Factory[:learner, email: input[:email]] }

      it 'returns error' do
        post_json '/learners', input
        expect(last_response.status).to eq(422)
        learner = parsed_body
        expect(learner['errors']['email']).to include('has already been taken')
      end
    end
  end
end
