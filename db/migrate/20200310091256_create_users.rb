class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default: false

      t.datetime :activated_at
      t.timestamps

      t.index :email, unique: true
      t.index :name, unique: true
    end
  end
end
