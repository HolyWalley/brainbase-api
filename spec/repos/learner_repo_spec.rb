# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Brainbase::Repos::LearnerRepo do
  describe '#create' do
    it 'creates a user' do
      learner = subject.create(
        email: 'john.doe@example.com',
        password_digest: '12345678',
        nickname: 'johndoe',
        first_name: 'Yasha',
        last_name: 'Krasnov',
        age: rand(18..65),
      )

      expect(learner).to be_a(Brainbase::Learner)
      expect(learner.id).not_to be_nil
      expect(learner.first_name).to eq('Yasha')
      expect(learner.last_name).to eq('Krasnov')
      expect(learner.created_at).not_to be_nil
      expect(learner.updated_at).not_to be_nil
    end
  end

  describe '#all' do
    before do
      subject.create(
        email: 'john.doe@example.com',
        password_digest: '12345678',
        nickname: 'johndoe',
        first_name: 'Yasha',
        last_name: 'Krasnov',
        age: rand(18..65),
      )
    end

    it 'returns all learners' do
      learners = subject.all
      expect(learners.count).to eq(1)
      expect(learners.first).to be_a(Brainbase::Learner)
    end
  end

  describe '#find_by_email' do
    let(:result) { subject.find_by_email(email) }

    let(:email) { 'john@example.com' }
    let!(:learner) { Factory[:learner, email: email] }

    it { expect(result).to be_a(Brainbase::Learner) }
    it { expect(result.to_h).to eq(learner.to_h) }
  end
end
