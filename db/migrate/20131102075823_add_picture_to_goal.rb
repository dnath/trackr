class AddPictureToGoal < ActiveRecord::Migration
  def self.up
    add_attachment :goals, :picture
  end

  def self.down
    remove_attachment :goals, :picture
  end
end
