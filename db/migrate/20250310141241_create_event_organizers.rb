class CreateEventOrganizers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_organizers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
