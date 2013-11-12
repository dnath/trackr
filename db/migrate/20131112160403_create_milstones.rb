class CreateMilstones < ActiveRecord::Migration
  def change
    create_table :milstones do |t|
      t.string :goal_instance
      t.string :no_of_days
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
