class CreateSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :ground, null: false, foreign_key: true

      t.timestamps
    end
  end
end
