class CreateWastes < ActiveRecord::Migration[5.0]
  def change
    create_table :wastes do |t|
      t.string :name
      t.text :description
      t.string :image_name
      t.integer :weight

      t.timestamps
    end
  end
end
