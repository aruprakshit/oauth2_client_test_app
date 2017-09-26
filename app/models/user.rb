require 'openssl'

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :email, uniqueness: true

  serialize :public_key

  def valid_signature?(encrypted_string)
    string_to_encrypt = self.email
    rsa_from_pub = OpenSSL::PKey::RSA.new self.public_key
    rsa_from_pub.public_decrypt(encrypted_string) == string_to_encrypt
  end
end
