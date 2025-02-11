class ModifyBranches < ActiveRecord::Migration[8.0]
  def change
    rename_column :branches, :name, :city
    remove_column :branches, :description
  end
end
