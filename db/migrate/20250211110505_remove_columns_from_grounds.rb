class RemoveColumnsFromGrounds < ActiveRecord::Migration[8.0]
  def change
    remove_column :grounds, :ground_type, :string
    remove_column :grounds, :price_per_hour, :decimal
    remove_column :grounds, :availabiity, :boolean
  end
end
