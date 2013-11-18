class GoalInstance < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :milestones
  attr_accessible :cheer_ons, :end_date, :is_complete, :start_date, :user, :goal, :goal_id, :milestones 
end
