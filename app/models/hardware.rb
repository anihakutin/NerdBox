class Hardware < ActiveRecord::Base
  belongs_to :hardwareable, polymorphic: true
end
