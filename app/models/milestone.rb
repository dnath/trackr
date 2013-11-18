class Milestone < ActiveRecord::Base
belongs_to  :goal_instance
#foreign_key :goal_id
attr_accessible :description, :goal_instance, :no_of_days, :title, :goal_instance_id
  acts_as_commentable
end
