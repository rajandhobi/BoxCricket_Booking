class CreateBranches < ActiveRecord::Migration[8.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
