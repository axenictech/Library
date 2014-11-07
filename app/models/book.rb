class Book < ActiveRecord::Base
	has_many :issue_book
	has_many :books_tag

		validates :barcode_no,allow_blank: true,uniqueness:true,format:{with: /-\A[a-z A-Z]+\Z/,message:"Please enter barcode starting with -alphanumeric"}
		validates :book_no ,presence:true, uniqueness: true,numericality: {only_integer:true, greater_than:0}
		validates :title ,presence:true,length: {minimum: 1, maximum: 50}
		validates :author ,presence:true,length: {minimum: 1, maximum: 50},format: {with: /\A[a-z A-Z]+\Z/,message:"Please enter only letter allows"}

	   

	has_and_belongs_to_many :tags

  
	has_and_belongs_to_many :tags
	
 	

	
end
