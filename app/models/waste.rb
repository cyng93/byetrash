class Waste < ApplicationRecord
  has_many :thrown_wastes, dependent: :destroy

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :weight
end
