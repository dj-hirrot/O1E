class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps

      t.index :code, unique: true
      t.index :name, unique: true
    end
  end
end
