class IssueBook < ActiveRecord::Base
	 
	 belongs_to  :book
	 belongs_to  :student
	 belongs_to  :employee


     validates :book, presence: true
     validates :issue_date, presence: true
     validates :due_date, presence: true
     validates :status, presence: true

	 has_one :fine

	 has_one :fine
end
