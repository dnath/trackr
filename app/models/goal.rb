class Goal < ActiveRecord::Base
  has_many :goal_instances
  belongs_to :user
  has_attached_file :picture
  validates :title, presence: true
  attr_accessible :description, :title, :user, :picture, :goal_instances
  
  
  before_update :ensure_no_followers
  before_destroy :ensure_no_followers
  
   
  private
    def ensure_no_followers
      #check goal instance table to check if there are any current users
      current_users_exist = false
      goal_instances.each {|goal_instance|
        if !goal_instance.is_complete
          return false
        end
      }
      return true
    end
end

