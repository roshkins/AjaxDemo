class Secret < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :author, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates :title, :body, :author, :recipient, :presence => true
end
