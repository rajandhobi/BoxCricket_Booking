class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :booking, null: false, foreign_key: true
      t.decimal :amount
      t.string :status, default: "pending"
      t.string :transaction_id

      t.timestamps
    end
  end
end
