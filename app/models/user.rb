class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :email, uniqueness: true
end
