class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
        t.references :issue_book, index: true
        t.decimal    :amount
      t.timestamps
    end
  end
end
