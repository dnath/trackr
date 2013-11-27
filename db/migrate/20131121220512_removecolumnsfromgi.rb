class Removecolumnsfromgi < ActiveRecord::Migration
  def change
   remove_column :goal_instances, :Milestones, :id_number
  end

end
