# frozen_string_literal: true

module Brainbase
  module Web
    Router = Hanami::Router.new do
      post '/learners', to: Controllers::Learners::Create
      post '/sessions', to: Controllers::Sessions::Create
      put  '/sessions', to: Controllers::Sessions::Update
    end
  end
end
