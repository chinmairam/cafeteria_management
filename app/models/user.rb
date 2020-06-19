class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  has_many :orders

  def is_clerk?
    clerk = role == "clerk" ? true : false
  end

  def is_owner?
    owner = role == "owner" ? true : false
  end

  def self.clerks
    User.all.where("role = ?", "clerk")
  end

  def self.owners
    User.all.where("role = ?", "owner")
  end

  def self.customers
    User.all.where("role = ?", "customer")
  end

  def self.get_user_by_email(email)
    user = all.where("email = ?", email).exists? ? find_by(email: email) : false
  end
end
