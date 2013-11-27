class Milestone < ActiveRecord::Base
  belongs_to :goal_instance
  attr_accessible :description, :duration, :is_complete, :milestones, :goal_instance_id
end
