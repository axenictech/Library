class IssueBook < ActiveRecord::Base
	 
	 belongs_to  :book
	 belongs_to  :student
	 belongs_to  :employee
<<<<<<< HEAD

=======
>>>>>>> 36777cf626852cb7271ef6bd3c3a3c92e3ed2c78
     validates :book, presence: true
     validates :issue_date, presence: true
     validates :due_date, presence: true
     validates :status, presence: true
<<<<<<< HEAD

	 has_one :fine

=======
	 has_one :fine
>>>>>>> 36777cf626852cb7271ef6bd3c3a3c92e3ed2c78
end
