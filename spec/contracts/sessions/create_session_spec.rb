# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Brainbase::Contracts::Sessions::CreateSession do
  let(:result) { subject.call(input) }

  context 'when email is missing' do
    let(:input) { { password: '12345678' } }

    it { expect(result).to be_failure }
    it { expect(result.errors[:email]).to include('is missing') }
  end

  context 'when password is missing' do
    let(:input) { { email: 'john@example.com' } }

    it { expect(subject.call(input)).to be_failure }
    it { expect(result.errors[:password]).to include('is missing') }
  end

  context 'when valid' do
    let(:input) { { email: 'john@example.com', password: '12345678' } }

    it { expect(subject.call(input)).to be_success }
  end
end
