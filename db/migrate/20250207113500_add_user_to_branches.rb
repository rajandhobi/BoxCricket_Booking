class AddUserToBranches < ActiveRecord::Migration[8.0]
  def change
    add_reference :branches, :user, foreign_key: true
  end
end
