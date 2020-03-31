class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :done

      t.timestamps
    end
  end
end
