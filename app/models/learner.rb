# frozen_string_literal: true

class Learner < ApplicationRecord
  has_many :pieces
  has_many :pieces_connections

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end
end
