# frozen_string_literal: true

module Brainbase
  class Learner < ROM::Struct
    def full_name
      "#{first_name} #{last_name}"
    end

    def password
      BCrypt::Password.new(password_digest)
    end
  end
end
