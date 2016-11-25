class CreateWastes < ActiveRecord::Migration[5.0]
  def change
    create_table :wastes do |t|
      t.string :name
      t.text :description
      t.integer :weight

      t.timestamps
    end
  end
end
