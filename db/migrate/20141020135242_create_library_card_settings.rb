class CreateLibraryCardSettings < ActiveRecord::Migration
  def change
    create_table :library_card_settings do |t|
      t.references :course, index: true
      t.references :category, index: true
      t.integer    :books_issuable
      t.integer    :time_period
      t.timestamps
    end
  end
end
