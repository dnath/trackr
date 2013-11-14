class Milestone < ActiveRecord::Base
belongs_to :user  
attr_accessible :description, :goal_instance, :no_of_days, :title, :user
  acts_as_commentable
end
