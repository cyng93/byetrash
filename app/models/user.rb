class User < ApplicationRecord
  has_many :thrown_wastes, dependent: :destroy

  validates_uniqueness_of :username
  validates_length_of :username, minimum: 4,
                                 too_short: 'need to has at least 5 characters'
  validates_length_of :password, minimum: 4,
                                 too_short: 'need to has at least 4 characters',
                                 on: :create

  has_secure_password

  def get_score
    start_time = "2016-12-19 00:00:00 +0800".to_time
    end_time = DateTime.current.in_time_zone('Taipei')
    day_passed = ((end_time-start_time)/1.day).to_i + 1

    if day_passed <= 7
      return self.score_week1
    else
      return self.score_week2
    end
  end

  def update_score(new_score)
    start_time = "2016-12-19 00:00:00 +0800".to_time
    end_time = DateTime.current.in_time_zone('Taipei')
    day_passed = ((end_time-start_time)/1.day).to_i + 1

    if day_passed <= 7
      self.update(score_week1: new_score)
    else
      self.update(score_week2: new_score)
    end
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
