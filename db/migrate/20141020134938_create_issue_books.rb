class CreateIssueBooks < ActiveRecord::Migration
  def change
    create_table :issue_books do |t|
      t.references :book, index: true
      t.references :student, index: true
      t.references :employee, index: true      
      t.date       :issue_date
      t.date       :due_date
      t.date       :returned_date
      t.string     :status
      t.integer    :no_of_time_book_renewed
      t.timestamps
    end
  end
end
