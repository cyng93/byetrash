class ChangeUsersColumn < ActiveRecord::Migration[5.0]
  def change
    remove_columns :users, :email, :score
    add_column :users, :score_week1, :integer, default: 0
    add_column :users, :score_week2, :integer, default: 0
  end
end
