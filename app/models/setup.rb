class Setup < ActiveRecord::Base
  belongs_to :user
  has_many :hardwares, as: :hardwareable
end
