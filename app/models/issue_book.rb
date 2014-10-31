class IssueBook < ActiveRecord::Base
	 belongs_to  :book
	 belongs_to  :student
	 belongs_to  :employee
<<<<<<< HEAD
     validates :book, presence: true
     validates :issue_date, presence: true
     validates :due_date, presence: true
     validates :status, presence: true
=======
	 has_one :fine
>>>>>>> 82999a718d0a41eb489d82ada3d2d2c28b25b885
end
