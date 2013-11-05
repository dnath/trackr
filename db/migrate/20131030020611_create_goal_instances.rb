class CreateGoalInstances < ActiveRecord::Migration
  def change
    create_table :goal_instances do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :is_complete
      t.integer :cheer_ons
      t.integer :user_id
      t.integer :goal_id
      
      t.timestamps
    end
  end
end
