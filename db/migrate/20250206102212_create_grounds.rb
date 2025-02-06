class CreateGrounds < ActiveRecord::Migration[8.0]
  def change
    create_table :grounds do |t|
      t.string :name
      t.string :location
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.string :ground_type
      t.integer :capicity
      t.decimal :price_per_hour
      t.boolean :availabiity
      t.time :open_time
      t.time :close_time
      t.text :facility
      t.string :contact_number
      t.string :email
      t.text :description
      t.references :branch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
