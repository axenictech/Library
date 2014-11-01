class BookMoreDetail < ActiveRecord::Base
	has_many :book_more_field
	has_many :book_more_value
end
