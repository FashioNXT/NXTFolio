class UnconfirmedUser < ApplicationRecord
  validates :unconfirmed_email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :confirmation_token, presence: true
  validates :confirmation_sent_at, presence: true
end