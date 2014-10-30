class Book < ActiveRecord::Base

	has_many :issue_book
	has_many :books_tag
end
