class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.references :project, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :hour, index: true, foreign_key: true
      t.float :hours
      t.timestamp :starts_at
      t.timestamp :ends_at
      t.text :description
      t.boolean :billed

      t.timestamps null: false
    end
  end
end
