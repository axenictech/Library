class LibraryManagementController < ApplicationController
  def library_dashboard
  	
  end
   #-----------------------------Manage Books---------------------------------------------------
  def books
    @books = Book.all
    
  end

  def addbooks
    @book = Book.new

  end
  
  def saveNewBook
    if params[:type]=='1'

      p "----------haha in 1"

      @cust_tag= params["cust_tag"]
      p  params["tag_ids"]
      unless params["cust_tag"][0].nil?
      @cust_tag_tmp=Tag.create(name: @cust_tag)
      end
      params[:no_of_cpoies].to_i.times do |i|
 
        @book = Book.new
        @book.book_no = params["book"]["book_no"].to_i+i
        @book.title =params["book"]["title"]
        @book.author=params["book"]["author"]
        @book.status="Available"
       if @book.save
         begin
          params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tag_id: k)
        end
        rescue Exception => e
        end

        @cust_tag= params["cust_tag"]
      unless params["cust_tag"][0].nil?
          @book.books_tag.create(book_id: @book.id,tag_id: @cust_tag_tmp.id)
      end
         redirect_to library_management_books_path(@book)
        else
         
          render library_management_addbooks_path

        end 
         
        
      end
    
    else 

      p "hoho--------in 2"

      @cust_tag= params["cust_tag"][0]
      unless @cust_tag.nil?
        Tag.create(name: @cust_tag)
      end
     

        @book = Book.new
        @book.barcode_no = params["book"]["barcode_no"].to_i
        @book.book_no = params["book"]["book_no"].to_i
        @book.title =params["book"]["title"]
        @book.author=params["book"]["author"]
        @book.status="Available"
        @book.save
     
        begin
          params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tag_id: k)
        end
         rescue Exception => e
         end
        @cust_tag= params["cust_tag"][0]
        unless params["cust_tag"][0]==""
        @cust_tag_tmp=Tag.create(name: @cust_tag)
          @book.books_tag.create(book_id: @book.id,tag_id: @cust_tag_tmp.id)
        end

          redirect_to library_management_books_path(@book)
    end
p "-------------------------------------------4"
  end

  def books_sorted_list
  
  p "----------------"
  p params["sort_by"]
  p "------------"
  p get_fiterby_status_book['All']
  @books_filter = get_fiterby_status_book['All']

  @books=Book.where("status = ?",get_fiterby_status_book['All'])  

  p @books
  p "----------"
   
  end


  def view_selected_book

    @book=Book.find(params[:id])

  end

  def search_books
  	
  end

  def search_books_list_result

    p params["search_book"]

    @book_search_field = get_book_list_for_search["search_field"]
    p "-------------------"
    p @book_search_field
    p "-------------------"
    @book_search_choice = get_book_list_for_search["search_choice"]
    p get_book_list_for_search["search_choice"]

    if @book_search_choice=="Book Number"

        @books=Book.where("book_no=?",@book_search_field)
    elsif @book_search_choice=="Barcode"
        @books=Book.where("barcode_no=?",@book_search_field)
    elsif @book_search_choice=="Title"
        @books=Book.where("title=?",@book_search_field)
    elsif  @book_search_choice=="Tag"
        @books=Book.where(id: BooksTag.where(id: Tag.where(name: @book_search_field).take.books_tag).pluck(:book_id))
    else @book_search_choice=="Author"
        @books=Book.where("author=?",@book_search_field)
    end

  end

  def reserve_book
   p params[:book_id]

   @book = Book.where("id = ? AND status = 'Available'",params[:book_id]).take
   @book.update(status: 'Reserved')


  end

  def edit_book
    @book = Book.find(params[:id])
  end
  def update_book
     @book = Book.find(params[:id])

      @cust_tag= params["cust_tag"][0]
      unless @cust_tag.nil?
        Tag.create(name: @cust_tag)
      end
     
        @book.update(barcode_no: params["book"]["barcode_no"].to_i,book_no: params["book"]["book_no"].to_i,title: params["book"]["title"],author: params["book"]["author"],status: params["book"]["status"])
        
        @book.books_tag.each do |books_tag|
          books_tag.destroy
        end

        params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tag_id: k)
        end

        @cust_tag= params["cust_tag"][0]
        unless params["cust_tag"][0]==""
        @cust_tag_tmp=Tag.create(name: @cust_tag)
        @book.books_tag.create(book_id: @book.id,tag_id: @cust_tag_tmp.id)
        end
       redirect_to library_management_books_path(@book)
 end

 def delete_book
  @book=Book.find(params[:id])
     @book.books_tag.each do |books_tag|
          books_tag.destroy
        end
         @book.destroy
         redirect_to library_management_books_path(@book)
 end
 
  #---------------------------------------------------------------------------------------------
  def return_books
  	
  end
  
  def library_card_settings
  	
  end
  def manage_barcodes
  	
  end
  def movement_log
  	
  end
  def book_renewal
  	
  end
 
  def library_fines
  	
  end
  def manage_tags
  	
  end

#issue Book Actions
  def issue_books
         
        if params["issue_book"]['student_employee_id']=="" && params["issue_book"]['student_employee_id']==""
        flash[:alert]="Please Select Student or Employee"
        @book=Book.where(book_no: params["issue_book"]['book_no']).take
        @issue_book=IssueBook.new
        redirect_to library_management_book_issue_select_student_employee_path(@book.book_no)
    
        else

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
         @issue_book.status="Borrowed"
          if params["issue_book"]['is_student']=="Student"
             student=@issue_book.student=Student.where(id: params["issue_book"]['student_employee_id']).take
          else
             @issue_book.employee=Employee.where(id: params["issue_book"]['student_employee_id']).take
          end
        begin
         if @issue_book.save
          @message="Book has been issued "
          @book.update(status: "Borrowed")
          p "-----------------------------"
        end
          redirect_to library_management_search_book_for_issue_path(@message)
        rescue Exception =>e
        @issue_book=IssueBook.new
        redirect_to  library_management_book_issue_select_student_employee_path(@book,@issue_book)     
        flash[:alert]="Please Select Student/Employee"
        end
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
   	@books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'Available' OR status='Reserved')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def student_employee_list
  
  begin

  if params["search"]['filter']=="Student"
  	@student=Student.where(admission_no: params["search"]['id']).take
    @book=Book.where(id: params["search"]['book_id'])
  	 @no_of_books_to_issue=LibraryCardSetting.where(course_id:@student.batch.course_id,category_id: @student.category_id).pluck(:books_issuable)

     @no_of_books_issued=IssueBook.where(book_id: @book,student_id: Student.where(batch_id: Batch.where(course_id: @student.batch.course_id),category_id: @student.category_id)).count

     p "--------------------------------------------------------"+ no_of_books_to_issue+"    "+no_of_books_issued



  else
  	
  	@employee=Employee.where(employee_number: params["search"]['id']).take
  	
  end
  
  rescue Exception =>e
    p e
  end
  end

  def get_book_details


  begin

  if params["is_student"]=="Student"
  	@student=Student.where(id: params['id']).take
  	@books_taken=IssueBook.where("student_id=? and status='Borrowed'",@student.id)
  else
  	@employee=Employee.where(id: params['id']).take
  	@books_taken=IssueBook.where("employee_id=? and status='Borrowed'",@employee.id)
  end
  
  rescue Exception =>e
  end

  end

  
  def search_book_for_return_result
    @book_no=get_book_no_for_search['bookno_barcode']
    @books=Book.where("(book_no = ? OR barcode_no = ?) AND (status = 'Borrowed')", get_book_no_for_search['bookno_barcode'], get_book_no_for_search['bookno_barcode'])   
  end
  def search_book_for_return
    
  end
  def process_return_book
     @book=IssueBook.where("book_id = ? AND status='Borrowed'", params['id']).take   
  end
  def return_books
    begin
   @book=IssueBook.where("id = ? AND status='Borrowed'",params["returnbook"]["book_id"]).take   
   if @book.due_date >=Date.today
   @book.update(status: "Available",returned_date: Date.today)
   @book.book.update(status: "Available")
   @message="Book has been returned "
   redirect_to library_management_search_book_for_return_path(@message)
   else
   
   @book.update(status: "Available",returned_date: Date.today)
   @book.book.update(status: "Available")
   @message="Book has been returned "
   Fine.create(issue_book_id: @book.id,amount: params["returnbook"]["amount"])
   redirect_to library_management_search_book_for_return_path(@message)

   end 
   rescue Exception=> e
    @message="Book Alredy returned "
    redirect_to library_management_search_book_for_return_path(@message)
   end
  end


  
  def library_card_setting_show
  end

  def library_get_library_card_setting
    #  @cource_choice = get_library_card_setting_choice["course_id"]
    # p @cource_choice
     p "----------------------------"
    p params[:cources_id]
    @cource= Course.find(params[:cources_id])
    @librarycards  = LibraryCardSetting.where(course_id: params[:cources_id])
  end

  def library_card_new
    @cource= Course.find(params[:id])
    @librarycard = LibraryCardSetting.new


  end

  def library_card_setting_add
    @cource= Course.find(params[:card_add][:course_id])
    @librarycard=  @cource.library_card_setting.create(params.require(:card_add).permit!)
     @librarycards =LibraryCardSetting.where(course_id: params[:card_add][:course_id])
    
  end

  def library_card_setting_edit  
    @librarycard =LibraryCardSetting.find(params[:id])
  
    end

   def library_card_setting_update
    @librarycard =LibraryCardSetting.where(id: params[:id]).take
    @librarycard.update(params.require(:card_add).permit!)
    @librarycards =LibraryCardSetting.where(course_id: params[:card_add][:course_id])

  end

  def library_card_setting_delete
    @librarycards =LibraryCardSetting.where(id: params[:id]).take
    @librarycard =LibraryCardSetting.where(id: params[:id]).take
    course_id=@librarycard.course.id
    @librarycards.destroy
    @librarycards =LibraryCardSetting.where(course_id: course_id)        
  end

  def manage_additional_details
    
  end
  def book_additional_details
  
  additional_details= BookMoreDetail.create()
  

  end


 private
 def get_book_no_for_search
 	params.require(:search).permit!
 end

def books_params
  params.require(:book).permit!
 end

 def tags_params
  params.require(:tag).permit!
 end


 def get_fiterby_status_book
  params.require(:sort_by).permit!
end

def get_book_list_for_search
  params.require(:search_book).permit!
end

def get_library_card_setting_choice
    params.require(:search_library_setting).permit!
end

end
