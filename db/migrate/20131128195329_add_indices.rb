class AddIndices < ActiveRecord::Migration
  def self.up 
    add_index :goals, :user_id
    add_index :goal_instances, :user_id
    add_index :goal_instances, :goal_id
    add_index :users,  :fb_id
  end 
    
  def self.down 
    remove_index :goals, :user_id
    remove_index :goal_instances,  :user_id
    remove_index :goal_instances,  :goal_id
    remove_index :users, :fb_id
  end 
end
