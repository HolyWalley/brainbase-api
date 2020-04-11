# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Brainbase::Contracts::Learners::CreateLearner do
  let(:attributes) { Factory.structs[:learner].to_h.merge(password: '12345678') }

  context 'required nick_name' do
    let(:input) do
      attributes.slice(:email, :password, :first_name, :last_name, :age)
    end

    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:nick_name]).to include('is missing')
    end
  end

  context 'requires email' do
    let(:input) do
      attributes.slice(:nick_name, :password, :first_name, :last_name, :age)
    end

    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:email]).to include('is missing')
    end
  end

  context 'requires email of right format' do
    let(:input) do
      attributes.slice(:nick_name, :password, :first_name, :last_name, :age)
                .merge(email: 'email')
    end

    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:email]).to include('not a valid email format')
    end
  end

  context 'requires password' do
    let(:input) do
      attributes.slice(:nick_name, :first_name, :last_name, :age)
    end

    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:password]).to include('is missing')
    end
  end

  context 'password cannot be less than 8 symbols' do
    let(:input) do
      attributes.slice(:nick_name, :first_name, :last_name, :age).merge(password: '1234567')
    end

    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:password]).to include('size cannot be less than 8')
    end
  end

  context 'when valid parameters given' do
    let(:input) { attributes }

    let(:result) { subject.call(input) }

    it 'is valid' do
      expect(result).to be_success
    end
  end
end
