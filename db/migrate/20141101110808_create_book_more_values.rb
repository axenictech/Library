class CreateBookMoreValues < ActiveRecord::Migration
  def change
    create_table :book_more_values do |t|
      t.references :book_more_detail, index: true
      t.string   :value
      t.timestamps
    end
  end
end
