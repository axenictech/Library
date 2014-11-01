class Book < ActiveRecord::Base
	has_many :issue_book
	has_and_belongs_to_many :tags
	has_many :book_more_detail
end
