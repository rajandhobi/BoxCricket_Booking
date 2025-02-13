class AddUserIdToGrounds < ActiveRecord::Migration[8.0]
  def change
    add_reference :grounds, :user, foreign_key: true
  end
end
