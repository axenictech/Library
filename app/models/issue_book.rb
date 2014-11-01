class IssueBook < ActiveRecord::Base
	 
	 belongs_to  :book
	 belongs_to  :student
	 belongs_to  :employee
end
