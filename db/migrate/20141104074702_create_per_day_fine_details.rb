class CreatePerDayFineDetails < ActiveRecord::Migration
  def change
    create_table :per_day_fine_details do |t|
      t.decimal :fine_per_day
      t.timestamps
    end
  end
end
