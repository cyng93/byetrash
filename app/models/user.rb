class User < ApplicationRecord
  has_many :thrown_wastes, dependent: :destroy

  validates_uniqueness_of :username
  validates_length_of :username, minimum: 4,
                                 too_short: 'need to has at least 5 characters'
  validates_length_of :password, minimum: 4,
                                 too_short: 'need to has at least 4 characters',
                                 on: :create

  has_secure_password

  # TODO - match coresponding week's score
  def get_score
    return self.score_week1
  end

  def update_score(new_score)
    self.update(score_week1: new_score)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
