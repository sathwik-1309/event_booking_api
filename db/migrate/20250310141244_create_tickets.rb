class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_type, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :quantity_available, null: false, default: 0
      t.references :event, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
