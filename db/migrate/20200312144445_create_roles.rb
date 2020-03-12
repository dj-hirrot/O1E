class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, default: ''
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
