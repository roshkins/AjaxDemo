class Friendship < ActiveRecord::Base
  attr_accessible :friended_id, :friender_id

  belongs_to :friender, :class_name => "User", :foreign_key => :friender_id,
             :primary_key => :id

  belongs_to :friendee, :class_name => "User", :foreign_key => :friended_id,
             :primary_key => :id
end
