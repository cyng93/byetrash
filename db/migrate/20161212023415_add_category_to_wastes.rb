class AddCategoryToWastes < ActiveRecord::Migration[5.0]
  def change
    add_column :wastes, :category, :string, default: ''
  end
end
