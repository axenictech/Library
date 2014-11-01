class Book < ActiveRecord::Base

	has_many :issue_book
	has_many :books_tag

		
		
		validates :book_no ,presence:true, uniqueness: true
		validates :title ,presence:true,length: {minimum: 1, maximum: 50},format: {with: /\A[a-z A-Z]+\Z/,message:"Please enter only letter allows"}
		validates :author ,presence:true,length: {minimum: 1, maximum: 50},format: {with: /\A[a-z A-Z]+\Z/,message:"Please enter only letter allows"}

	   
end
