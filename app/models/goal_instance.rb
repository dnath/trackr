class GoalInstance < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :goal, touch: true
  has_many :milestones
  attr_accessible :cheer_ons, :end_date, :is_complete, :start_date, :user, :goal, :goal_id, :milestones, :milestones_attributes
  accepts_nested_attributes_for :milestones, :limit => 3, :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true
end
