class AddStatusToSlots < ActiveRecord::Migration[8.0]
  def change
    add_column :slots, :status, :string, default: "available"
  end
end
