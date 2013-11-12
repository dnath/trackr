class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :goal_instance_id
      t.string :comment
      t.string :user_id
      t.string :timestamp

      t.timestamps
    end
  end
end
