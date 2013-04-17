class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field     = :email_address
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  attr_protected :admin
end