# frozen_string_literal: true

require_relative 'config/application'

Brainbase::Application.finalize!

run Brainbase::Web.app
