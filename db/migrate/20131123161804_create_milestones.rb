class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.references :goal_instance
      t.string :description
      t.string :duration
      t.boolean :is_complete

      t.timestamps
    end
    add_index :milestones, :goal_instance_id
  end
end
