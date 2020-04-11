# frozen_string_literal: true

module Brainbase
  module Web
    Router = Hanami::Router.new do
      post '/learners', to: Controllers::Learners::Create
      post '/sessions', to: Controllers::Sessions::Create
    end
  end
end
