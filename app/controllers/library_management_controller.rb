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

      @cust_tag= params["cust_tag"][0]
      unless @cust_tag.nil?
        Tag.create(name: @cust_tag)
      end
      p "=---------------------------------"
      p  params["tag_ids"]
      @cust_tag_tmp=Tag.create(name: @cust_tag)
      params[:no_of_cpoies].to_i.times do |i|

        @book = Book.new
        @book.book_no = params["book"]["book_no"].to_i+i
        @book.title =params["book"]["title"]
        @book.author=params["book"]["author"]
        @book.status="Available"
        @book.save
         
        params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tag_id: k)
        end

        @cust_tag= params["cust_tag"][0]
      unless params["cust_tag"][0]==""
          @book.books_tag.create(book_id: @book.id,tag_id: @cust_tag_tmp.id)
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
     

        params["tag_ids"].each do |k|
          @book.books_tag.create(book_id:params["book_id"],tag_id: k)
        end

        @cust_tag= params["cust_tag"][0]
        unless params["cust_tag"][0]==""
        @cust_tag_tmp=Tag.create(name: @cust_tag)
          @book.books_tag.create(book_id: @book.id,tag_id: @cust_tag_tmp.id)
        end


    end

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
        @books=Book.books_tag.tag("name",@book_search_field)
      
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

end
