class CreateBooksTags < ActiveRecord::Migration
  def change
    create_table :books_tags do |t|
      t.references :book, index: true
      t.references :tags, index: true
      t.timestamps
    end
  end
end
