class Comment < ActiveRecord::Base
  attr_accessible :comment, :goal_instance_id, :timestamp, :user_id
end
