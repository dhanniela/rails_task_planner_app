class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.datetime :due_date, null: false
      t.datetime :scheduled_date
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
