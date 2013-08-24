class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :secret_taggings, :class_name => "SecretTagging",
           :foreign_key => :tag_id

  has_many :secrets, :through => :secret_taggings, :source => :secret
end
