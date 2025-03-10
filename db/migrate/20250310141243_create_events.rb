class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :date, null: false
      t.string :venue, null: false
      t.references :event_organizer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
