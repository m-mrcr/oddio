class User < ApplicationRecord
  has_many :recordings
  has_many :tours
  has_one :app_auth
  has_one :google_auth

  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :display_name, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :first_name
  validates_presence_of :role

  enum role: ['user', 'admin']

  after_create :add_vote_token

  def add_vote_token
    self.update(vote_token: SecureRandom.hex)
  end
end
