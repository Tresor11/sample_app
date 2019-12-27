# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :password, length: { minimum: 6, maximum: 72 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { minimum: 5, maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
