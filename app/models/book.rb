class Book < ActiveRecord::Base
	has_many :issue_book
<<<<<<< HEAD
	has_many :books_tag

		
		
		validates :book_no ,presence:true, uniqueness: true
		validates :title ,presence:true,length: {minimum: 1, maximum: 50},format: {with: /\A[a-z A-Z]+\Z/,message:"Please enter only letter allows"}
		validates :author ,presence:true,length: {minimum: 1, maximum: 50},format: {with: /\A[a-z A-Z]+\Z/,message:"Please enter only letter allows"}

	   
=======
	has_and_belongs_to_many :tags
<<<<<<< HEAD
	has_many :book_more_detail
=======
>>>>>>> 36777cf626852cb7271ef6bd3c3a3c92e3ed2c78
>>>>>>> 2783959cd646b7f126b200a6f3b363057136fcae
end
