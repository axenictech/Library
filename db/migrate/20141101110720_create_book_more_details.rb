class CreateBookMoreDetails < ActiveRecord::Migration
  def change
    create_table :book_more_details do |t|
      t.string :name
      t.string :status
      t.string :is_mandatory
      t.string :input_method
      t.boolean :is_active  
      t.integer  :serial_no
      t.timestamps
    end
  end
end
