class User < ActiveRecord::Base
  has_many :goals
  has_many :goal_instances
  attr_accessible :fb_id, :first_name, :last_name, :goals, :goal_instances
end
