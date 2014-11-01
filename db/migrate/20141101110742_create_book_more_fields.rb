class CreateBookMoreFields < ActiveRecord::Migration
  def change
    create_table :book_more_fields do |t|
      t.references :book, index: true
      t.references :book_more_detail, index: true
      t.string     :value
      t.timestamps
    end
  end
end
