class LibraryManagementController < ApplicationController
  def library_dashboard
  	
  end
  def manage_books
  	
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
         @issue_book=IssueBook.new
         @book=Book.where(book_no: params["issue_book"]['book_no']).take
         @issue_book.book=@book
         
         begin
          d=Date.parse(params["issue_book"]['issue_date'])
          d2=Date.parse(params["issue_book"]['due_date'])
         rescue
        @issue_book=IssueBook.new
        redirect_to  library_management_book_issue_select_student_employee_path(@book,@issue_book)     
        flash[:alert]="Due/Issue date not in correct format"
         end

         @issue_book.issue_date=params["issue_book"]['issue_date']
         @issue_book.due_date=params["issue_book"]['due_date']
         @issue_book.status="borrowed"
          if params["issue_book"]['is_student']=="Student"
             @issue_book.student=Student.where(id: params["issue_book"]['student_employee_id']).take
          else
             @issue_book.employee=Employee.where(id: params["issue_book"]['student_employee_id']).take
          end
        begin
         if @issue_book.save
          @message="Book has been issued "
          @book.update(status: "borrowed")
          p "-----------------------------"
        end
          redirect_to library_management_search_book_for_issue_path(@message)
        rescue Exception =>e
        @issue_book=IssueBook.new
        redirect_to  library_management_book_issue_select_student_employee_path(@book,@issue_book)     
        flash[:alert]="Please Select Student/Employee"
        end

  end
  def search_book_for_issue
  	
  end
  def book_issue_select_student_employee
  	
  	@book=Book.where(book_no: params["id"]).take
  	@issue_book=IssueBook.new
  end

  def search_book_for_issue_result
  	@book_no=get_book_no_for_search['bookno_barcode']
   	@books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'available' OR status='reserved')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
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

  
  def search_book_for_return_result
    @book_no=get_book_no_for_search['bookno_barcode']
    @books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'borrowed')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def search_book_for_return
    
  end
  def process_return_book
     @book=IssueBook.where("book_id = ? AND status='borrowed'", params['id']).take   
  end
  def return_books
    begin
   @book=IssueBook.where("id = ? AND status='borrowed'",params["returnbook"]["book_id"]).take   
   if @book.due_date >=Date.today
   @book.update(status: "available",returned_date: Date.today)
   @book.book.update(status: "available")
   @message="Book has been returned "
   redirect_to library_management_search_book_for_return_path(@message)
   else
   
   @book.update(status: "available",returned_date: Date.today)
   @book.book.update(status: "available")
   @message="Book has been returned "
   Fine.create(issue_book_id: @book.id,amount: params["returnbook"]["amount"])
   redirect_to library_management_search_book_for_return_path(@message)

   end 
   rescue Exception=> e
    @message="Book Alredy returned "
    redirect_to library_management_search_book_for_return_path(@message)
   end
  end



 private
 def get_book_no_for_search
 	params.require(:search).permit!
 end


end
