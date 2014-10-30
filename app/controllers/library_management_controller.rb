class LibraryManagementController < ApplicationController
  def library_dashboard
  	
  end
  def manage_books
  	
  end
  def return_books
  	
  end
  def search_books
  	
  end
  def library_card_settings
  	
  end
  def manage_barcodes
  	
  end
  def movement_log
  	
  end
  def book_renewal
  	
  end
  def manage_additional_details
  	
  end
  def library_fines
  	
  end
  def manage_tags
  	
  end

#issue Book Actions
  def issue_books
  	
  end
  def search_book_for_issue
  	
  end
  def book_issue_select_student_employee
  	
  	@book=Book.where(book_no: params["id"]).take
  	@issue_book=IssueBook.new
  end

  def search_book_for_issue_result
  	@book_no=get_book_no_for_search['bookno_barcode']
   	@books=Book.where("book_no = ? OR barcode_no = ? AND status = 'available' OR status='reserved'", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def student_employee_list
  
  begin

  if params["search"]['filter']=="Student"
  	@student=Student.where(admission_no: params["search"]['id']).take
  	
  else
  	
  	@employee=Employee.where(employee_number: params["search"]['id']).take
  	
  end
  
  rescue Exception =>e
  end
  end

  def get_book_details


  begin

  if params["is_student"]=="Student"
  	@student=Student.where(id: params['id']).take
  	@books_taken=IssueBook.where("student_id=? and status='borrowed'",@student.id)
  else
  	@employee=Employee.where(id: params['id']).take
  	@books_taken=IssueBook.where("employee_id=? and status='borrowed'",@employee.id)
  end
  
  rescue Exception =>e
  end

  end


 private
 def get_book_no_for_search
 	params.require(:search).permit!
 end


end
