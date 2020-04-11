# frozen_string_literal: true

Factory.define(:learner) do |f|
  f.sequence(:email) { "john#{_1}@example.com" }

  f.first_name 'John'
  f.last_name 'Doe'
  f.sequence(:nick_name) { "johndoe#{_1}" }
  f.city { fake(:address, :city) }

  f.age { rand(18..65) }

  f.password_digest { BCrypt::Password.create(fake(:internet, :password, min_length: 8)) }

  f.timestamps
end
