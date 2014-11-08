class Change < ActiveRecord::Migration
  def change
  	add_column :issue_books, :no_of_time_book_renewed, :integer
  end
end
