class CreateOtherLibrarySettings < ActiveRecord::Migration
  def change
    create_table :other_library_settings do |t|
      t.decimal :fine_per_day
      t.integer :times_renew_book
      t.timestamps
    end
  end
end
