class LibraryCardSetting < ActiveRecord::Base
	belongs_to  :course
	
	belongs_to  :category

		validates :category,presence:true
  		validates :books_issuable,presence:true,numericality: {only_integer:true, greater_than:0}
  		validates :time_period,presence:true,numericality: {only_integer:true, greater_than:0}

end
