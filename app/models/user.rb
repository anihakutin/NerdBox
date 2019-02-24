class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password

  has_many :resources
  has_many :hardwares, as: :hardwareable
  has_one :setup
end
