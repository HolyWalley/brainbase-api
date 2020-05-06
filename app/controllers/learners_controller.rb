# frozen_string_literal: true

class LearnersController < ApplicationController
  schema(:create) do
    required(:learner).hash do
      required(:email).value(:string)
      required(:password).value(:string)
      required(:username).value(:string)
    end
  end

  before_action :validate_params
  skip_before_action :authorize_access_request!

  def create
    case resolve("learners.create_learner").(safe_params[:learner])
    in Success(learner)
      render json: learner_serializer.new(learner)
    in Failure(:email_has_already_been_taken)
      render json: { errors: [{ email: :has_already_been_taken }] }, status: 422
    in Failure(:username_has_already_been_taken)
      render json: { errors: [{ username: :has_already_been_taken }] }, status: 422
    end
  end

  private

  def learner_serializer
    LearnerSerializer
  end
end
