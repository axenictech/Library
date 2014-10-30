class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer  :book_no
      t.string   :title
      t.string   :author
      t.string   :barcode_no
      t.string   :status
      t.timestamps
    end
  end
end
