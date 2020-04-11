# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Brainbase::Transactions::Sessions::CreateSession do
  let(:result) { subject.call(input) }

  context 'when user does not exist' do
    subject { described_class.new(learner_repo: learner_repo) }

    let(:input) do
      {
        email: 'john@example.com',
        password: '12345678'
      }
    end

    let(:learner_repo) do
      instance_double('Brainbase::Repos::LearnerRepo', find_by_email: nil)
    end

    it { expect(result).to be_failure }
    it { expect(result.failure).to eq(:learner_not_found) }
  end

  context 'when password is invalid' do
    let(:input) do
      {
        email: 'john@example.com',
        password: '12345678'
      }
    end

    before { Factory[:learner, email: input[:email]] }

    it { expect(result).to be_failure }
    it { expect(result.failure).to eq(:wrong_password) }
  end

  context 'when password is valid' do
    let(:input) do
      {
        email: 'john@example.com',
        password: '12345678'
      }
    end

    before do
      Factory[
        :learner,
        email: input[:email],
        password_digest: BCrypt::Password.create(input[:password])
      ]
    end

    it { expect(result).to be_success }
    it { expect(result.success[:access]).not_to be_nil }
    it { expect(result.success[:refresh]).not_to be_nil }
  end
end
