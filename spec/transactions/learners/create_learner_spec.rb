# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Brainbase::Transactions::Learners::CreateLearner do
  let(:learner_repo) { double('LearnerRepo') }
  let(:learner) { Brainbase::Learner.new(id: 1, first_name: 'Yasha') }

  subject { described_class.new(learner_repo: learner_repo) }

  context 'with valid input' do
    let(:input) { Factory.structs[:learner].to_h.merge(password: '12345678') }

    it 'creates a learner' do
      expect(learner_repo).to receive(:create) { learner }
      expect(learner_repo).to receive(:find_by_email) { nil }
      result = subject.call(input)
      expect(result).to be_success
      expect(result.success).to eq(learner)
    end

    context 'when email has been taken' do
      it 'returns failure' do
        expect(learner_repo).to receive(:find_by_email) { learner }
        expect(learner_repo).not_to receive(:create) { learner }
        result = subject.call(input)
        expect(result).to be_failure
        expect(result.failure).to eq(:email_has_already_been_taken)
      end
    end
  end

  context 'with invalid input' do
    let(:input) { { age: rand(18..65) } }

    it 'does not create a user' do
      expect(learner_repo).not_to receive(:create)
      result = subject.call(input)
      expect(result).to be_failure
      expect(result.failure.errors[:nick_name]).to include('is missing')
      expect(result.failure.errors[:email]).to include('is missing')
      expect(result.failure.errors[:password]).to include('is missing')
    end
  end
end
