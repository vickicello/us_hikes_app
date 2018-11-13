class User < ApplicationRecord
  has_secure_password
  has_many :hikes
  has_many :comments
  has_many :commented_hikes, through: :hikes

  validates :username, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
      user.username = auth_hash.info.name
      user.password = SecureRandom.hex
    end
  end  
  
  def completed_hikes
    self.hikes.where(completed: true)
  end

  def uncompleted_hikes
    self.hikes.where(completed: false)
  end
end
