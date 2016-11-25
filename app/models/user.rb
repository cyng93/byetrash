class User < ApplicationRecord
  has_many :user_wastes, dependent: :destory

  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 4,
                                 too_short: 'need to has at least 5 characters'
  validates_length_of :password, minimum: 8, too_short:
                                 'need to has at least 8 characters'

  has_secure_password
end
